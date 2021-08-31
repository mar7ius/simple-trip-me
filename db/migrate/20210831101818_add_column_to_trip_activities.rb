class AddColumnToTripActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :trip_activities, :day, :integer
  end
end
