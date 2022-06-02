class AddAddressFieldsToLocations < ActiveRecord::Migration[7.0]
  def change
    add_column :locations, :street_number, :integer
    add_column :locations, :street_name, :string
    add_column :locations, :governing_district, :string
    add_column :locations, :governing_district_type, :integer
    add_column :locations, :city, :string
    add_column :locations, :zip_code, :string
  end
end
