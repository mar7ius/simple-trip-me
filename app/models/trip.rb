class Trip < ApplicationRecord
  belongs_to :user

  has_many :trip_activities
  has_many :activities, through: :trip_activities

  has_many :trip_hotels
  has_many :hotels, through: :trip_hotels

  has_many :trip_flights
  has_many :flights, through: :trip_flights

  validates :start_date, :duration, :destination, presence: true
end
