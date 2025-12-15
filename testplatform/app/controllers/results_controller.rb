class ResultsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    # Security: Only show results for the current user
    user_id = current_user.id
    
    # Get user's recent attempts
    attempts = DB.exec_params(
      "SELECT a.*, t.title as test_title FROM attempts a 
       JOIN tests t ON a.test_id = t.id 
       WHERE a.user_id = $1 
       ORDER BY a.submitted_at DESC 
       LIMIT 10", 
      [user_id]
    ).to_a
    
    @recent_attempts = attempts
    
    # If specific score/total params are passed, use them (for immediate results)
    if params[:score] && params[:total]
      @score = params[:score].to_i
      @total = params[:total].to_i
      @percentage = ((@score.to_f / @total) * 100).round(2)
    end
  end
end
