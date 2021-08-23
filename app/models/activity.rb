class Activity < ApplicationRecord
  has_many :trip_activities

  # validates :address, :category, :description, :price, :day, :duration, presence: true
end
