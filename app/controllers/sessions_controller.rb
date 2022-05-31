class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    # finds existing user, checks to see if user can be authenticated
    if user.present? && user.authenticate(params[:password])
    # sets up user.id sessions
      puts "Made it Auth"
      session[:user_id] = user.id
      redirect_to welcome_path, notice: 'Logged in successfully'
    else
      flash[:alert] = 'Invalid username or password'
      redirect_to sign_in_path
    end
  end
  def destroy
    # deletes user session
    session[:user_id] = nil
    flash[:alert] = 'Logged Out'
    redirect_to sign_in_path
  end

  def login
  end

  def welcome
  end
end
