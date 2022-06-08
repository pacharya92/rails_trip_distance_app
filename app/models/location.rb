class Location < ApplicationRecord
  enum governing_district_type: [:State, :Province]
  belongs_to :trip
end
