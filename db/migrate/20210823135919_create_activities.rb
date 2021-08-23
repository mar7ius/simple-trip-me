class CreateActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.string :address
      t.string :category
      t.text :description
      t.float :price
      t.integer :duration
      t.integer :day

      t.timestamps
    end
  end
end
