class Location < ApplicationRecord
  enum governing_district_type: [:State, :Province]
  belongs_to :trip
  validates :street_number, :street_name, :governing_district, :city, :zip_code, :country,  presence: true
end
