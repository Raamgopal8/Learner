class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  # Enable CSRF protection with proper exception handling
  protect_from_forgery with: :exception
  
  # Skip CSRF only for API endpoints
  skip_before_action :verify_authenticity_token, if: :api_request?

  helper_method :api_request?, :current_user, :logged_in?

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_login
    unless logged_in?
      session[:return_to] = request.fullpath
      redirect_to login_path, alert: "You must be logged in to access this section"
    end
  end

  def api_request?
    request.format.json? || request.path.start_with?('/api/')
  end
end
