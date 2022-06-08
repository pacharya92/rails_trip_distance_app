class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  has_secure_password
  # has_many :trips
  # validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
end
