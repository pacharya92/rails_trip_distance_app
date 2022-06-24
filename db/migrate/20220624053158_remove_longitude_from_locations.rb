class RemoveLongitudeFromLocations < ActiveRecord::Migration[7.0]
  def change
    remove_column :locations, :longitude, :float
  end
end
