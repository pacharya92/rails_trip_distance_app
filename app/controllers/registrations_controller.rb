class RegistrationsController < ApplicationController
  # instantiates new user
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
    # stores saved user id in a session
      session[:user_id] = @user.id
      redirect_to welcome_path, notice: 'Successfully created account'
    else
      # Show error if user cannot be saved to the database 
      # Flash errors and redirect back to sign_up_path
      flash[:messages] = @user.errors.full_messages
      redirect_to sign_up_path
    end
  end
  private
  def user_params
    # strong parameters
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end