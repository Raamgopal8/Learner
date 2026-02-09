class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_or_initialize_by(email: params[:email])
    
    if params[:name].present?
      user.name = params[:name]
      user.save
    end

    if user.persisted?
      session[:user_id] = user.id
      redirect_to (session[:return_to] || root_path), notice: "Logged in successfully"
      session.delete(:return_to)
    else
      flash.now[:alert] = "Could not create account"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out"
  end
end
