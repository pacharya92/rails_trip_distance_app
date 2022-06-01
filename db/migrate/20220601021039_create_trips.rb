class CreateTrips < ActiveRecord::Migration[7.0]
  def change
    create_table :trips do |t|
      t.string :name
      t.json :location_one
      t.json :location_two

      t.timestamps
    end
  end
end
