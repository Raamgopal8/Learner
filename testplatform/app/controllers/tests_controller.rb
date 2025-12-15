class TestsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @tests = Test.all.order(created_at: :desc)
  end

  def show
    test_id = params[:id]
    Rails.logger.info "Fetching test with ID: #{test_id}"
    
    @test = Test.find_by(id: test_id)
    
    unless @test
      Rails.logger.error "Test not found with ID: #{test_id}"
      render json: { error: 'Test not found' }, status: :not_found
      return
    end
    
    Rails.logger.info "Test found: #{@test.title}"
    
    @questions = @test.questions.order(:id)
    
    Rails.logger.info "Found #{@questions.length} questions for test #{test_id}"
    
    # For authenticated users, track test access
    if user_signed_in?
      # Log test access for analytics
      Rails.logger.info "User #{current_user.id} accessed test #{test_id}"
    end
  end
end
