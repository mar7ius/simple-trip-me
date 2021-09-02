class Activity < ApplicationRecord
  has_many :trip_activities

  accepts_nested_attributes_for :trip_activities
  # validates :address, :category, :description, :price, :day, :duration, presence: true
  def formatted_duration
    hours = self.duration / 60
    minutes = self.duration % 60
    if minutes == 0
      "#{ hours }h"
    else
      "#{ hours }h#{minutes }min"
    end
  end
end
