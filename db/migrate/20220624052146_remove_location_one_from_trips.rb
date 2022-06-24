class RemoveLocationOneFromTrips < ActiveRecord::Migration[7.0]
  def change
    remove_column :trips, :location_one, :json
  end
end
