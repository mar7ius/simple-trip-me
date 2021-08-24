class AddLongAndLatToActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :long, :float
    add_column :activities, :lat, :float
  end
end
