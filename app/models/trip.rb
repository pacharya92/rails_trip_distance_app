class Trip < ApplicationRecord
  belongs_to :user
  has_many :locations
  accepts_nested_attributes_for :locations
  validates :name, presence: true
end
