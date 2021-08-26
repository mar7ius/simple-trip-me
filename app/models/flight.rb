class Flight < ApplicationRecord
  has_many :trip_flights

  accepts_nested_attributes_for :trip_flights
  # validates :departure, :arrival, :departure_date, :arrival_date, :price, :duration, presence: true

  def flight_duration
    return nil unless duration
    duration[2..-1].gsub('M','').gsub('H', ' h ')
  end
end
