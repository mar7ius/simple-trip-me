class Trip < ApplicationRecord
  AIRPORTS_ORIGIN = ["PAR", "TLS"]
  CITIES_ORIGIN = {
    ["Madrid", "Barcelona"].sort! => "Spain",
    ["Paris", "Lyon", "Bordeaux", "Toulouse", "Marseille"].sort! => "France",
    ["Berlin", "Frankfurt"].sort! => "Germany",
    ["London", "Manchester", "Liverpool", "Edimburg", "Glasgow"].sort! => "United Kingdom",
  }
  AIRPORTS_DESTINATION = ["SFO", "LAX"]
  CITIES_DESTINATION = {
    ["Adelaide", "Melbourne", "Sydney", "Canberra"].sort! => "Australia",
    ["San Francisco", "Los Angeles", "Las Vegas"].sort! => "California",
    ["Montreal", "Quebec City", "Toronto", "Vancouver"].sort! => "Canada",
    ["Athens", "Mykonos", "Paros", "Santorini"].sort! => "Cyclades",
    ["Pisa", "Florence", "Roma", "Bologna"].sort! => "Tuscany",
    ["Salt Lake City", "St George", "Provo", "Cedar City"].sort! => "Utah",
    ["Port Elizabeth", "Cape Town", "Maseru", "Durban"].sort! => "Wild Coast",
  }
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
