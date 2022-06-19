module TripsHelper
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
