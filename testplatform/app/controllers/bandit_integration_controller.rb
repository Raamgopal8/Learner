require 'net/http'
require 'uri'
require 'json'

class BanditIntegrationController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:reward]
  
  def reward
    # For now, use a default user ID since authentication is removed
    user_id = 1 # Default user ID
    course_id = params[:course_id].to_i
    context = JSON.parse(params[:context]) rescue []

    # Validate parameters
    unless course_id > 0
      render json: { error: 'Invalid course ID' }, status: :bad_request
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
end
