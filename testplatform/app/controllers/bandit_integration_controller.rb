require 'net/http'
require 'uri'
require 'json'

class BanditIntegrationController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:reward]
  
  def reward
    # Security: Only allow users to submit rewards for themselves
    user_id = current_user.id
    course_id = params[:course_id].to_i
    context = JSON.parse(params[:context]) rescue []

    # Validate parameters
    unless course_id > 0
      render json: { error: 'Invalid course ID' }, status: :bad_request
      return
    end

    # Verify the user actually has access to this course/test
    unless user_has_course_access?(user_id, course_id)
      render json: { error: 'Unauthorized access to course' }, status: :forbidden
      return
    end

    # Decide reward value: click = 0.5, enroll = 2.0 etc. Here we treat click = 1.0
    reward_val = 1.0

    begin
      uri = URI("http://localhost:8000/reward")
      http = Net::HTTP.new(uri.host, uri.port)
      req = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json'})
      req.body = { 
        user_id: user_id, 
        course_id: course_id, 
        reward: reward_val, 
        context: context 
      }.to_json
      resp = http.request(req)

      # Log reward submission for audit
      Rails.logger.info "User #{user_id} submitted reward for course #{course_id}: #{reward_val}"

      render json: { 
        message: "Reward sent successfully",
        status: resp.code.to_i
      }, status: :ok
    rescue StandardError => e
      Rails.logger.error "Failed to send reward: #{e.message}"
      render json: { error: 'Failed to process reward' }, status: :internal_server_error
    end
  end

  private

  def user_has_course_access?(user_id, course_id)
    # Check if user has attempted a test related to this course
    # This is a simplified check - you may need to adjust based on your data model
    result = DB.exec_params(
      "SELECT COUNT(*) as count FROM attempts a 
       JOIN tests t ON a.test_id = t.id 
       WHERE a.user_id = $1 AND t.id = $2", 
      [user_id, course_id]
    ).first
    
    result['count'].to_i > 0
  end
end
