class TripsController < ApplicationController
  # instantiates new trip
  def new
    @trip = Trip.new
  end
  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      # validate the trip is valid 
      redirect_to show_trip_path
    else
      # puts "In error"
      # puts @user.errors.full_messages
      flash[:messages] = @user.errors.full_messages
      redirect_to new_trip_path
    end
  end
  # Change to find current trip
  def show
    @trip = Trip.new
  end

  private
  def trip_params
    # strong parameters
    params.require(:trip).permit(:name, :location_one, :location_two)
  end
end
