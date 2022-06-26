class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :set_current_user

  def set_current_user
    # finds user with session data and stores it if present
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end
  def require_user_logged_in!
    # allows only logged in user
    redirect_to sign_in_path, alert: 'You must be signed in' if Current.user.nil?
  end
  def redirect_if_user_logged_in
    # redirect to trip_show page if logged in 
    redirect_to trip_show_path, alert: 'You are already logged in' if Current.user.present?
  end
end
