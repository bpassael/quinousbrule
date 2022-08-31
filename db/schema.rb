# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_08_31_205911) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "annual_footprints", force: :cascade do |t|
    t.float "annual_footprint_kgCO2e"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "input_transport_plane?"
    t.float "input_transport_flights_short"
    t.float "input_transport_flights_middle"
    t.float "input_transport_flights_long"
    t.float "fp_total_plane"
    t.boolean "input_transport_car?"
    t.string "input_transport_car_type"
    t.string "input_transport_car_carburant"
    t.float "input_transport_car_age"
    t.float "input_transport_car_passengers"
    t.integer "input_transport_car_km"
    t.string "input_transport_two_wheels"
    t.integer "input_transport_scooter_km"
    t.integer "input_transport_moto_km"
    t.float "fp_total_transport_indiv"
    t.boolean "input_transport_train?"
    t.float "input_transport_train_trips_short"
    t.float "input_transport_train_trips_middle"
    t.float "input_transport_train_trips_long"
    t.float "input_transport_bus_hours_week"
    t.float "input_transport_metro_tram_hours_week"
    t.float "fp_total_public_transit"
    t.integer "input_home_surface"
    t.boolean "input_home_old?"
    t.string "input_home_type"
    t.string "input_home_heat_type"
    t.integer "input_home_elec_monthly_bill"
    t.integer "input_home_heat_bill"
    t.float "input_home_users"
    t.float "fp_total_home"
    t.string "input_food_diet"
    t.string "input_food_waste"
    t.float "fp_total_food"
    t.string "input_consumption_tech"
    t.string "input_consumption_appliances"
    t.string "input_consumption_clothing"
    t.float "fp_total_consumption"
    t.boolean "input_food_bottled_water?"
  end

  create_table "measurements", force: :cascade do |t|
    t.string "title"
    t.float "kgCO2e_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "eq_minutes_flight_jet_bollore"
    t.float "eq_km_yacht_arnault"
    t.string "additional_info"
    t.string "source_link"
    t.string "source_name"
  end

  create_table "representatives", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "circo_key"
    t.string "email"
    t.string "twitter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
