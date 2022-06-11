class ApplicationController < ActionController::Base
  before_action :set_current_user
  helper_method :address_format, :seconds_to_str
  def set_current_user
    # finds user with session data and stores it if present
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end
  def require_user_logged_in!
    # allows only logged in user
    redirect_to sign_in_path, alert: 'You must be signed in' if Current.user.nil?
  end
  # Convert seconds to hours and minutes
  def seconds_to_str(seconds)
    if seconds.present?
      Time.at(seconds).utc.strftime("%kh %Mmin %Ss")
      #"#{Time.at(seconds).utc.strftime("%k")}h #{Time.at(seconds).utc.strftime("%M")}min and #{Time.at(seconds).utc.strftime("%S")}s"
    end
  end
  def address_format(location)
    "#{location.street_number} #{location.street_name}, #{location.city}, #{location.governing_district} #{location.zip_code}, #{location.country}"
  end
end
