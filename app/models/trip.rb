class Trip < ApplicationRecord
  AIRPORTS = ["PAR", "LAX"]
  attr_accessor :departure_flight, :arrival_flight

  belongs_to :user

  has_many :trip_activities
  has_many :activities, through: :trip_activities

  has_many :trip_hotels
  has_many :hotels, through: :trip_hotels

  has_many :trip_flights
  has_many :flights, through: :trip_flights
  # has_many :departure, through: :flights

  validates :start_date, :duration, :destination, presence: true
  # validates :, inclusion: { in: AIRPORTS }
end
