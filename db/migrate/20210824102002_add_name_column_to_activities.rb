class AddNameColumnToActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :name, :string
  end
end
