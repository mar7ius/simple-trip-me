class CreateFlights < ActiveRecord::Migration[6.0]
  def change
    create_table :flights do |t|
      t.string :departure
      t.string :arrival
      t.date :departure_date
      t.date :arrival_date
      t.float :price
      t.integer :duration
      t.boolean :departure_flight, null: false, default: false

      t.timestamps
    end
  end
end
