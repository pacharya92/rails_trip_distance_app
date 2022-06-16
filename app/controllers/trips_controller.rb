class TripsController < ApplicationController
  # Instantiates new trip and build location attributes
  def new
    @trip = Trip.new
    @trip.locations.build
  end
  def create
   
    @locations = get_location_str
    puts " "
    puts "Line 11: Printing Trip parms"
    puts @locations
    puts " "

    if !@locations.blank?
      @distance = Google::Maps.distance(@locations[0], @locations[1])
      @travel_time_route = Google::Maps.route(@locations[0], @locations[1])
      @travel_time_in_seconds = @travel_time_route.duration.value

      puts "-------------------------------------------"
      puts "This is location_one: #{@locations[0]}"
      puts " "
      puts " "
      puts "This is location_two: #{@locations[1]}"
      puts "------------------------------------------"
      puts " "
      puts "The distance is " + @distance
      puts "The travel time is " + @travel_time_route.duration.text
      puts "The travel time in seconds is " + @travel_time_route.duration.value.to_s
      puts " "
    end

    @google_values = {"user_id" => Current.user.id, "distance" => remove_commas(@distance).to_i, "travel_time" =>  @travel_time_in_seconds}
    @trip = Trip.new(trip_params.merge(@google_values))
    
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
    @trips = Trip.where(user_id: Current.user.id)
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
  def remove_commas(str)
    # Remove commas from string before saving to database 
    # 1,743 => 1743
    if !str.nil?
      str.gsub(/[\s,]/ ,"")
    end
  end
  def get_location_str
    location_one = "#{trip_params[:locations_attributes].values.first[:street_number]} #{trip_params[:locations_attributes].values.first[:street_name]}, #{trip_params[:locations_attributes].values.first[:city]}, #{trip_params[:locations_attributes].values.first[:governing_district]} #{trip_params[:locations_attributes].values.first[:zip_code]}, #{trip_params[:locations_attributes].values.last[:country]}"
    location_two = "#{trip_params[:locations_attributes].values.last[:street_number]} #{trip_params[:locations_attributes].values.last[:street_name]}, #{trip_params[:locations_attributes].values.last[:city]}, #{trip_params[:locations_attributes].values.last[:governing_district]} #{trip_params[:locations_attributes].values.last[:zip_code]}, #{trip_params[:locations_attributes].values.last[:country]}"
    # Check if string isempty after removing commas

    if remove_commas(location_one).present? && remove_commas(location_two).present?
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
