class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  # Enable CSRF protection with proper exception handling
  protect_from_forgery with: :exception
  
  # Skip CSRF only for API endpoints that use token authentication
  skip_before_action :verify_authenticity_token, if: :api_request?

  # Use Devise authentication only
  before_action :authenticate_user!

  private

  def api_request?
    request.format.json? || request.path.start_with?('/api/')
  end

  def current_user
    @current_user ||= begin
      # Use Devise session authentication
      super
    end
  rescue StandardError => e
    Rails.logger.error "Authentication error: #{e.message}"
    nil
  end

  def authenticate_user!
    unless current_user
      if api_request?
        render json: { error: 'Unauthorized - Valid authentication required' }, status: :unauthorized
      else
        redirect_to login_path, alert: 'You need to sign in or sign up before continuing.'
      end
    end
  end

  def user_signed_in?
    super
  end

  helper_method :current_user, :user_signed_in?
end
