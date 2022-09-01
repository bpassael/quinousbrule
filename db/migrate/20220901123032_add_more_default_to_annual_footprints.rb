class AddMoreDefaultToAnnualFootprints < ActiveRecord::Migration[7.0]
  def change
    change_column :annual_footprints, :input_transport_car, :boolean, default: true
    change_column :annual_footprints, :input_transport_car_type, :string, default: "Moyenne"
    change_column :annual_footprints, :input_transport_car_carburant, :string, default: "Thermique"
    change_column :annual_footprints, :input_transport_car_age, :float, default: 9
    change_column :annual_footprints, :input_transport_car_passengers, :float, default: 1.2
    change_column :annual_footprints, :input_transport_car_km, :integer, default: 12200
    change_column :annual_footprints, :input_transport_two_wheels, :string, default: "Scooter ou moto < 250"
    change_column :annual_footprints, :input_transport_scooter_km, :integer, default: 1000
    change_column :annual_footprints, :input_transport_moto_km, :integer, default: 0
    change_column :annual_footprints, :input_transport_train, :boolean, default: true
    change_column :annual_footprints, :input_transport_train_trips_short, :float, default: 1
    change_column :annual_footprints, :input_transport_train_trips_middle, :float, default: 0
    change_column :annual_footprints, :input_transport_train_trips_long, :float, default: 1
    change_column :annual_footprints, :input_transport_bus_hours_week, :float, default: 3
    change_column :annual_footprints, :input_transport_metro_tram_hours_week, :float, default: 3
    change_column :annual_footprints, :input_home_surface, :integer, default: 80
    change_column :annual_footprints, :input_home_old, :boolean, default: false
    change_column :annual_footprints, :input_home_type, :string, default: "Maison"
    change_column :annual_footprints, :input_home_heat_type, :string, default: "Electricité ou pompe à chaleur"
    change_column :annual_footprints, :input_home_elec_monthly_bill, :integer, default: 250
    change_column :annual_footprints, :input_home_heat_bill, :integer, default: 0
    change_column :annual_footprints, :input_home_users, :float, default: 2
    change_column :annual_footprints, :input_food_diet, :string, default: "Alimentation mixte"
    change_column :annual_footprints, :input_food_waste, :string, default: "Je réduis le gaspillage alimentaire"
    change_column :annual_footprints, :input_consumption_tech, :string, default: "Moyennement"
    change_column :annual_footprints, :input_consumption_appliances, :string, default: "Moyennement"
    change_column :annual_footprints, :input_consumption_clothing, :string, default: "Occasionnellement"
    change_column :annual_footprints, :input_food_bottled_water, :boolean, default: true
  end
end
