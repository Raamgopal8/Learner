class TestsController < ApplicationController
   # before_action :require_login
    def index
      @tests = Test.all
    end
  
    def show
      @test = Test.find(params[:id])
  
      # Create an attempt record when user starts
      @attempt = current_user.attempts.create(test: @test, started_at: Time.current)
  
      # We'll render a JS-enabled page that fetches questions via JSON
    end
  end