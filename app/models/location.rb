class Location < ApplicationRecord
  enum governing_district_type: [:state, :province]
  belongs_to :trip
end
