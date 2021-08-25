class AddLongAndLatToHotels < ActiveRecord::Migration[6.0]
  def change
    add_column :hotels, :longitude, :float
    add_column :hotels, :latitude, :float
  end
end
