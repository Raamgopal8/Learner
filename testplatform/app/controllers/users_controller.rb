class UsersController < ApplicationController
  def index
    @users = DB.exec("SELECT * FROM users;")
  end

  def create
    name = params[:name]
    email = params[:email]
    DB.exec_params("INSERT INTO users (name, email) VALUES ($1, $2);", [name, email])
    redirect_to '/users'
  end
end