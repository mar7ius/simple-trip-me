class Trip < ApplicationRecord
  AIRPORTS_ORIGIN = ["PAR", "TLS"]
  AIRPORTS_DESTINATION = ["SFO", "LAX", "LAS"]
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
end
