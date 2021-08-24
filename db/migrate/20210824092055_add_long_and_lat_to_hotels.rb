class AddLongAndLatToHotels < ActiveRecord::Migration[6.0]
  def change
    add_column :hotels, :long, :float
    add_column :hotels, :lat, :float
  end
end
