class TripsController < ApplicationController
  # instantiates new trip
  def new
    # @trip = Trip.new
    @location_one = Location.new
    @location_two = Location.new
  end
  def create
  #@trip = Trip.new(trip_params)
    @location_one = Location.new(location_params)
    if @location_one.save
      # validate the trip is valid 
      redirect_to show_trip_path
    else
      # puts "In error"
      # puts @user.errors.full_messages
      flash[:messages] = @location_one.errors.full_messages
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
    params.require(:trip).permit(:name, :location_one, :location_two)
  end
  def location_params
    params.require(:location).permit(:street_number, :street_name, :city, :zip_code)
  end
end
