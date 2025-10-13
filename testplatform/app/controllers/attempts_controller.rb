class AttemptsController < ApplicationController
    before_action :require_login
    protect_from_forgery with: :null_session
  
    def create
      attempt = Attempt.find(params[:attempt_id])
      # params[:answers] expected to be array of { question_id: x, option_id: y }
      ActiveRecord::Base.transaction do
        attempt.answers.delete_all
        (params[:answers] || []).each do |a|
          attempt.answers.create!(question_id: a[:question_id], option_id: a[:option_id])
        end
        attempt.update(finished_at: Time.current, submitted: true)
        attempt.score!
      end
  
      render json: { ok: true, score: attempt.score }
    end
  end