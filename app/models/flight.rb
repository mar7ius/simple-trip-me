class Flight < ApplicationRecord
  has_many :trip_flights

  accepts_nested_attributes_for :trip_flights
  # validates :departure, :arrival, :departure_date, :arrival_date, :price, :duration, presence: true
end
