class Trip < ApplicationRecord
  AIRPORTS_ORIGIN = ["PAR", "TLS"]
  CITIES_ORIGIN = ["Paris", "Toulouse"]
  AIRPORTS_DESTINATION = ["SFO", "LAX"]
  CITIES_DESTINATION = ["San Francisco", "Los Angeles"]
  attr_accessor :departure_flight, :arrival_flight

  belongs_to :user

  has_many :trip_activities, dependent: :destroy
  has_many :activities, through: :trip_activities

  has_many :trip_hotels, dependent: :destroy
  has_many :hotels, through: :trip_hotels

  has_many :trip_flights, dependent: :destroy
  has_many :flights, through: :trip_flights
  # has_many :departure, through: :flights

  validates :start_date, :duration, :destination, presence: true
  # validates :, inclusion: { in: AIRPORTS }

  def price
    trip = self
    flights = trip.flights.pluck(:price).sum
    hotels = trip.hotels.pluck(:price).sum
    activities = trip.activities.pluck(:price).sum
    flights + hotels + activities
  end
end
