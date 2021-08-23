class CreateTripHotels < ActiveRecord::Migration[6.0]
  def change
    create_table :trip_hotels do |t|
      t.references :hotel, null: false, foreign_key: true
      t.references :trip, null: false, foreign_key: true

      t.timestamps
    end
  end
end
