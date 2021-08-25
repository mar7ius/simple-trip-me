# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_08_25_104311) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "address"
    t.string "category"
    t.text "description"
    t.float "price"
    t.integer "duration"
    t.integer "day"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "longitude"
    t.float "latitude"
    t.string "name"
  end

  create_table "flights", force: :cascade do |t|
    t.string "departure"
    t.string "arrival"
    t.date "departure_date"
    t.date "arrival_date"
    t.float "price"
    t.string "duration"
    t.boolean "departure_flight", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "compagnie_name"
    t.string "airport_iata_code"
  end

  create_table "hotels", force: :cascade do |t|
    t.string "address"
    t.integer "stars"
    t.text "description"
    t.float "price"
    t.integer "day"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "longitude"
    t.float "latitude"
    t.string "name"
  end

  create_table "trip_activities", force: :cascade do |t|
    t.bigint "activity_id", null: false
    t.bigint "trip_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["activity_id"], name: "index_trip_activities_on_activity_id"
    t.index ["trip_id"], name: "index_trip_activities_on_trip_id"
  end

  create_table "trip_flights", force: :cascade do |t|
    t.bigint "flight_id", null: false
    t.bigint "trip_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["flight_id"], name: "index_trip_flights_on_flight_id"
    t.index ["trip_id"], name: "index_trip_flights_on_trip_id"
  end

  create_table "trip_hotels", force: :cascade do |t|
    t.bigint "hotel_id", null: false
    t.bigint "trip_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hotel_id"], name: "index_trip_hotels_on_hotel_id"
    t.index ["trip_id"], name: "index_trip_hotels_on_trip_id"
  end

  create_table "trips", force: :cascade do |t|
    t.date "start_date"
    t.integer "duration"
    t.string "destination"
    t.integer "nb_people"
    t.boolean "booked", default: false, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_trips_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "trip_activities", "activities"
  add_foreign_key "trip_activities", "trips"
  add_foreign_key "trip_flights", "flights"
  add_foreign_key "trip_flights", "trips"
  add_foreign_key "trip_hotels", "hotels"
  add_foreign_key "trip_hotels", "trips"
  add_foreign_key "trips", "users"
end
