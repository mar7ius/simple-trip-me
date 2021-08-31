class RemoveColumnFromActivities < ActiveRecord::Migration[6.0]
  def change
    remove_column :activities, :day, :integer
  end
end
