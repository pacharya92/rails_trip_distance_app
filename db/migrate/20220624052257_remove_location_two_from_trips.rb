class RemoveLocationTwoFromTrips < ActiveRecord::Migration[7.0]
  def change
    remove_column :trips, :location_two, :json
  end
end
