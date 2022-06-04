class AddTravelTimeToTrips < ActiveRecord::Migration[7.0]
  def change
    add_column :trips, :travel_time, :time
  end
end
