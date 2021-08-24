class AddLongAndLatToActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :longitude, :float
    add_column :activities, :latitude, :float
  end
end
