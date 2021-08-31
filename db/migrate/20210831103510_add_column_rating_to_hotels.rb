class AddColumnRatingToHotels < ActiveRecord::Migration[6.0]
  def change
    add_column :hotels, :rating, :float
  end
end
