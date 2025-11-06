class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, 
      keys: [
        :first_name, 
        :last_name, 
        :username, 
        :email, 
        :password, 
        :password_confirmation,
        :date_of_birth,
        :receive_newsletter,
        :terms
      ]
    )
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, 
      keys: [
        :first_name, 
        :last_name, 
        :username, 
        :email, 
        :password, 
        :password_confirmation, 
        :current_password
      ]
    )
  end

  def after_sign_up_path_for(resource)
    flash[:notice] = "Welcome, #{resource.first_name}! Your account has been created successfully."
    root_path
  end

  def after_inactive_sign_up_path_for(resource)
    # This is used if you have confirmable enabled
    flash[:notice] = "Please check your email to confirm your account."
    root_path
  end
end