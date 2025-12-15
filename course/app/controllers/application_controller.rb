class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  skip_before_action :verify_authenticity_token

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :username, :email, :password, :password_confirmation, :date_of_birth, :receive_newsletter, :terms])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :username, :email, :password, :password_confirmation, :current_password])
  end

  private

  # Support both Devise and Firebase authentication
  def current_user
    @current_user ||= begin
      # First try Devise authentication (session-based)
      if super
        super
      # Then try Firebase authentication via token
      elsif request.headers['Authorization']&.start_with?('Bearer ')
        token = request.headers['Authorization'].split(' ').last
        firebase_payload = FirebaseAuthenticator.verify(token)
        if firebase_payload
          User.find_by(firebase_uid: firebase_payload['sub'])
        end
      end
    end
  end

  def user_signed_in?
    super || (current_user.present? && current_user.firebase_user?)
  end

  def authenticate_user!
    unless user_signed_in?
      redirect_to login_path, alert: 'You need to sign in or sign up before continuing.'
    end
  end

  helper_method :current_user, :user_signed_in?
end