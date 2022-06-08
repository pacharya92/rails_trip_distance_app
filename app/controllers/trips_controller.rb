class TripsController < ApplicationController
  # instantiates new trip with two locations
  def new
    @trip = Trip.new
    @trip.locations.build
    @location_one = Location.new
    @location_two = Location.new
  end
  def create
    @trip = Trip.new(trip_params)
    
    # Check trip_params 
    # DELETE THIS
    puts trip_params[:locations_attributes].values.first
    puts trip_params[:locations_attributes].values.last
    puts " "
    if @trip.save
      # validate the trip is valid 
      # Run Google map logic to get travel distance and travel time
      redirect_to show_trip_path
    else
      # puts "In error"
      # puts @user.errors.full_messages
      flash[:messages] = @location.errors.full_messages
      redirect_to new_trip_path
    end
  end
  # Change to find current trip
  def show
    @location = Location.all
  end

  private
  def trip_params
    # strong parameters
    params.require(:trip).permit(:name, locations_attributes: [:street_number, :street_name, :governing_district_type, :governing_district, :city, :zip_code])
  end
  def location_params
    params.require(:location).permit(:street_number, :street_name, :governing_district_type, :governing_district, :city, :zip_code)
  end
end
