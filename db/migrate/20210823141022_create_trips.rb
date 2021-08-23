class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.date :start_date
      t.integer :duration
      t.string :destination
      t.integer :nb_people
      t.boolean :booked, null: false, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
