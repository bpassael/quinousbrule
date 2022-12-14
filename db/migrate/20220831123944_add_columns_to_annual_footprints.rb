class AddColumnsToAnnualFootprints < ActiveRecord::Migration[7.0]
  def change
    add_column :annual_footprints, :input_transport_plane?, :boolean
    add_column :annual_footprints, :input_transport_flights_short, :float
    add_column :annual_footprints, :input_transport_flights_middle, :float
    add_column :annual_footprints, :input_transport_flights_long, :float
    add_column :annual_footprints, :fp_total_plane, :float
    add_column :annual_footprints, :input_transport_car?, :boolean
    add_column :annual_footprints, :input_transport_car_type, :string
    add_column :annual_footprints, :input_transport_car_carburant, :string
    add_column :annual_footprints, :input_transport_car_age, :float
    add_column :annual_footprints, :input_transport_car_passengers, :float
    add_column :annual_footprints, :input_transport_car_km, :integer
    add_column :annual_footprints, :input_transport_two_wheels, :string
    add_column :annual_footprints, :input_transport_scooter_km, :integer
    add_column :annual_footprints, :input_transport_moto_km, :integer
    add_column :annual_footprints, :fp_total_transport_indiv, :float
    add_column :annual_footprints, :input_transport_train?, :boolean
    add_column :annual_footprints, :input_transport_train_trips_short, :float
    add_column :annual_footprints, :input_transport_train_trips_middle, :float
    add_column :annual_footprints, :input_transport_train_trips_long, :float
    add_column :annual_footprints, :input_transport_bus_hours_week, :float
    add_column :annual_footprints, :input_transport_metro_tram_hours_week, :float
    add_column :annual_footprints, :fp_total_public_transit, :float
    add_column :annual_footprints, :input_home_surface, :integer
    add_column :annual_footprints, :input_home_old?, :boolean
    add_column :annual_footprints, :input_home_type, :string
    add_column :annual_footprints, :input_home_low_cons?, :boolean
    add_column :annual_footprints, :input_home_heat_type, :string
    add_column :annual_footprints, :input_home_elec_monthly_bill, :integer
    add_column :annual_footprints, :input_home_heat_bill, :integer
    add_column :annual_footprints, :input_home_users, :float
    add_column :annual_footprints, :fp_total_home, :float
    add_column :annual_footprints, :input_food_diet, :string
    add_column :annual_footprints, :input_food_waste, :string
    add_column :annual_footprints, :fp_total_food, :float
    add_column :annual_footprints, :input_consumption_tech, :string
    add_column :annual_footprints, :input_consumption_appliances, :string
    add_column :annual_footprints, :input_consumption_clothing, :string
    add_column :annual_footprints, :fp_total_consumption, :float
  end
end
