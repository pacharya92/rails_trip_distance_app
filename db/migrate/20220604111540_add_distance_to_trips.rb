class AddDistanceToTrips < ActiveRecord::Migration[7.0]
  def change
    add_column :trips, :distance, :float
  end
end
