class TripsController < ApplicationController
  # Instantiates new trip and build location attributes
  def new
    @trip = Trip.new
    @trip.locations.build
  end
  # Create new trip and calcuate distance and travel_time
  def create
    # Add current user_id to Trip 
    google_values_and_id = {"user_id" => Current.user.id}
    @locations = get_location_str
    if !@locations.blank?
      # Create new trip and calcuate distance and travel_time
      google_data = helpers.google_maps_route_data(@locations)
      google_values_and_id = {"user_id" => Current.user.id, "distance" => helpers.remove_commas(google_data[0]).to_i, "travel_time" =>  google_data[1]}
    end

    @trip = Trip.new(trip_params.merge(google_values_and_id))
    
    if @trip.save
      redirect_to show_trip_path
    else
      # Show error if trip cannot be saved to the database 
      # Flash errors and redirect back to new_trip_path
      flash[:messages] = @trip.errors.full_messages.join("<br/>").html_safe 
      redirect_to new_trip_path
    end
  end
  def show
    # Find all trips connected to current logged in user 
    # Setup pagination for views
    @pagy, @trips = pagy(Trip.where(user_id: Current.user.id), items: 10)
  end
  def governing_district
    # Get a list of governing districts depending on Country
    @target = params[:target]
    @governing_district = CS.get(params[:country]).invert
    # Respond with a turbo stream to update State/Provice select field
    respond_to do |format|
      format.turbo_stream
    end
  end
  def get_location_str
    location_one = "#{trip_params[:locations_attributes].values.first[:street_number]} #{trip_params[:locations_attributes].values.first[:street_name]}, #{trip_params[:locations_attributes].values.first[:city]}, #{trip_params[:locations_attributes].values.first[:governing_district]} #{trip_params[:locations_attributes].values.first[:zip_code]}, #{trip_params[:locations_attributes].values.last[:country]}"
    location_two = "#{trip_params[:locations_attributes].values.last[:street_number]} #{trip_params[:locations_attributes].values.last[:street_name]}, #{trip_params[:locations_attributes].values.last[:city]}, #{trip_params[:locations_attributes].values.last[:governing_district]} #{trip_params[:locations_attributes].values.last[:zip_code]}, #{trip_params[:locations_attributes].values.last[:country]}"
   
    # Check if string is empty after removing commas
    if helpers.remove_commas(location_one).present? && helpers.remove_commas(location_two).present?
      locations = [location_one, location_two]
    else
    # If the location string is empty no address infomation was enter in the form
    # Return an empty string so distance or travel_time is not calculated 
      locations = ""
    end
  end
  private
  # strong parameters
  def trip_params
    params
      .require(:trip)
      .permit(:name, :user_id, :distance, :travel_time, locations_attributes: [:street_number, :street_name, :country, :governing_district_type, :governing_district, :city, :zip_code])
      .each_value {|value| value.try(:strip!)}
  end
end
