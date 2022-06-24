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
  def google_maps_route_data(locations)
    # Call google_maps API to get disance and travel_time between locations
    @distance = Google::Maps.distance(@locations[0], @locations[1])
    @travel_time_route = Google::Maps.route(@locations[0], @locations[1])
    # Save travel_time as seconds in the database
    @travel_time_in_seconds = @travel_time_route.duration.value
    google_data = [@distance, @travel_time_in_seconds]
  end
end
