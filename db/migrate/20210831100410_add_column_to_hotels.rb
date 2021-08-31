class AddColumnToHotels < ActiveRecord::Migration[6.0]
  def change
    add_column :hotels, :img_link, :string
  end
end
