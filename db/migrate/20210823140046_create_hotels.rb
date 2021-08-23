class CreateHotels < ActiveRecord::Migration[6.0]
  def change
    create_table :hotels do |t|
      t.string :address
      t.integer :stars
      t.text :description
      t.float :price
      t.integer :day

      t.timestamps
    end
  end
end
