class RemoveColumnStarsFromHotels < ActiveRecord::Migration[6.0]
  def change
    remove_column :hotels, :stars, :integer
  end
end
