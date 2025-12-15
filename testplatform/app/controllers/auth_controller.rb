# frozen_string_literal: true

class AuthController < ApplicationController
  skip_before_action :authenticate_user!, only: [:login, :signup]

  def login
    # Render login page
  end

  def signup
    # Render signup page
  end

  def profile
    if current_user
      render json: { user: current_user.as_json(except: [:jti]) }
    else
      render json: { error: 'Not authenticated' }, status: :unauthorized
    end
  end

  def logout
    # Clear JWT token (client-side will handle this)
    render json: { message: 'Logged out successfully' }
  end
end
