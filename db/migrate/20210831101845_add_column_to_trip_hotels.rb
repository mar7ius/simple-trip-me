class AddColumnToTripHotels < ActiveRecord::Migration[6.0]
  def change
    add_column :trip_hotels, :day, :integer
  end
end
