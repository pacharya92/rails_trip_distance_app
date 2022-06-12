class TripsController < ApplicationController
  # instantiates new trip with two locations
  def new
    @trip = Trip.new
    @trip.locations.build
    @location_one = Location.new
    @location_two = Location.new
  end
  def create
    @location_one = trip_params[:locations_attributes].values.first[:street_number] + trip_params[:locations_attributes].values.first[:street_name] + ", " + trip_params[:locations_attributes].values.first[:city] + ", " + trip_params[:locations_attributes].values.first[:governing_district] + " " + trip_params[:locations_attributes].values.first[:zip_code] + ", " + trip_params[:locations_attributes].values.last[:country]
    @location_two = trip_params[:locations_attributes].values.last[:street_number] + trip_params[:locations_attributes].values.last[:street_name] + ", " + trip_params[:locations_attributes].values.last[:city] + ", " + trip_params[:locations_attributes].values.last[:governing_district] + " " + trip_params[:locations_attributes].values.last[:zip_code] + ", " + trip_params[:locations_attributes].values.last[:country] 
    
    @distance = Google::Maps.distance(@location_one, @location_two)
    @travel_time_route = Google::Maps.route(@location_one, @location_two)
    @travel_time_in_seconds = @travel_time_route.duration.value
    
    puts " "
    puts "The distance is " + @distance
    puts "The travel time is " + @travel_time_route.duration.text
    puts "The travel time in seconds is " + @travel_time_route.duration.value.to_s
    puts " "

    # Use https://github.com/josedonizetti/ruby-duration to convert seconds to days, hours and minutes
    # Or Time.at(t).utc.strftime("%H:%M:%S")
    @google_values = {"user_id" => Current.user.id, "distance" => @distance.gsub(/[\s,]/ ,"").to_i, "travel_time" =>  @travel_time_in_seconds}
    @trip = Trip.new(trip_params.merge(@google_values))
    
    if @trip.save
      # validate the trip is valid 
      # Run Google map logic to get travel distance and travel time
      redirect_to show_trip_path
    else
      # puts "In error"
      # puts @user.errors.full_messages
      flash[:messages] = @trip.errors.full_messages
      redirect_to new_trip_path
    end
  end
  # Change to find current trip
  def show
    @trips = Trip.where(user_id: Current.user.id)
  end
  def governing_district
    # Get a list of governing districts depending on Country
    @target = params[:target]
    @governing_district = CS.get(params[:country]).invert
    respond_to do |format|
      format.turbo_stream
    end
  end

  private
  def trip_params
    # strong parameters
    params.require(:trip).permit(:name, :user_id, :distance, :travel_time, locations_attributes: [:street_number, :street_name, :country, :governing_district_type, :governing_district, :city, :zip_code])
  end
  def location_params
    params.require(:location).permit(:street_number, :street_name, :country, :governing_district_type, :governing_district, :city, :zip_code)
  end
end
