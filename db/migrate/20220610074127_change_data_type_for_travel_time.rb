class ChangeDataTypeForTravelTime < ActiveRecord::Migration[7.0]
  def change
    change_column :trips, :travel_time, :float
  end
end
