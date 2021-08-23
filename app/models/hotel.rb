class Hotel < ApplicationRecord
  has_many :trip_hotels

  # validates :address, :stars, :description, :price, :day, presence: true
end
