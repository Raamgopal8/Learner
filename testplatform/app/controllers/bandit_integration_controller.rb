require 'net/http'
require 'uri'
require 'json'
class BanditIntegrationController < ApplicationController
  protect_from_forgery with: :null_session

  def reward
    user_id = params[:user_id].to_i
    course_id = params[:course_id].to_i
    context = JSON.parse(params[:context]) rescue []

    # Decide reward value: click = 0.5, enroll = 2.0 etc. Here we treat click = 1.0
    reward_val = 1.0

    uri = URI("http://localhost:8000/reward")
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json'})
    req.body = { user_id: user_id, course_id: course_id, reward: reward_val, context: context }.to_json
    resp = http.request(req)

    render plain: "Reward sent", status: resp.code.to_i
  end
end
