class TripsController < ApplicationController
  # instantiates new trip with two locations
  def new
    @trip = Trip.new
    @trip.locations.build
    @location_one = Location.new
    @location_two = Location.new
  end
  def create
    @location_one = trip_params[:locations_attributes].values.first[:street_number] + trip_params[:locations_attributes].values.first[:street_name] + ", " + trip_params[:locations_attributes].values.first[:city] + ", " + trip_params[:locations_attributes].values.first[:governing_district] + " " + trip_params[:locations_attributes].values.first[:zip_code]
    @location_two = trip_params[:locations_attributes].values.last[:street_number] + trip_params[:locations_attributes].values.last[:street_name] + ", " + trip_params[:locations_attributes].values.last[:city] + ", " + trip_params[:locations_attributes].values.last[:governing_district] + " " + trip_params[:locations_attributes].values.last[:zip_code]
    
    @trip = Trip.new(trip_params.merge(user_id: Current.user.id))
    
    @distance = Google::Maps.distance(@location_one, @location_two)
    @travel_time = Google::Maps.duration(@location_one, @location_two)
    
    puts " "
    puts "The distance is " + @distance
    puts "The travel time is " + @travel_time
    puts " "
    
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
    @trip = Trip.first
    @location = Location.all
  end

  private
  def trip_params
    # strong parameters
    params.require(:trip).permit(:name, :user_id, locations_attributes: [:street_number, :street_name, :country, :governing_district_type, :governing_district, :city, :zip_code])
  end
  def location_params
    params.require(:location).permit(:street_number, :street_name, :country, :governing_district_type, :governing_district, :city, :zip_code)
  end
end
