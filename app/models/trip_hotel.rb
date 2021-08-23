class TripHotel < ApplicationRecord
  belongs_to :trip
  belongs_to :hotel
end
