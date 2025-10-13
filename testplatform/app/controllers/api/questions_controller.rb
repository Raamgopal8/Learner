module Api
    class QuestionsController < ApplicationController
      before_action :require_login
      protect_from_forgery with: :null_session
  
      def index
        test = Test.find(params[:test_id])
        render json: test.questions.includes(:options).map { |q|
          {
            id: q.id,
            text: q.text,
            options: q.options.map { |o| { id: o.id, text: o.text } }
          }
        }
      end
    end
  end