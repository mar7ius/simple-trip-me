class TripFlight < ApplicationRecord
  belongs_to :flight
  belongs_to :trip
end
