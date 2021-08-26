class AddCodeImageToActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :code_image, :string
  end
end
