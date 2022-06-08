class AddTripIdToLocations < ActiveRecord::Migration[7.0]
  def change
    add_column :locations, :trip_id, :integer
    add_index  :locations, :trip_id
  end
end
