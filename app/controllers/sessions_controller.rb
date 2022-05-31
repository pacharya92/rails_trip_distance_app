class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:username])

    if !!@user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      message = "Something went wrong!"
      redirect_to login_path, notice: message
    end
  end

  def login
  end

  def welcome
  end
end
