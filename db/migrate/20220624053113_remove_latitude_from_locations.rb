class RemoveLatitudeFromLocations < ActiveRecord::Migration[7.0]
  def change
    remove_column :locations, :latitude, :float
  end
end
