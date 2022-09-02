class ChangeColumnsAgainDefaultAnnualFootprints < ActiveRecord::Migration[7.0]
  def change
    change_column :annual_footprints, :input_transport_flights_short, :integer, default: 1
    change_column :annual_footprints, :input_transport_flights_middle, :integer, default: 1
    change_column :annual_footprints, :input_transport_flights_long, :integer, default: 0
    change_column :annual_footprints, :input_transport_car_age, :integer, default: 9
    change_column :annual_footprints, :input_transport_train_trips_short, :integer, default: 1
    change_column :annual_footprints, :input_transport_train_trips_middle, :integer, default: 1
    change_column :annual_footprints, :input_transport_train_trips_long, :integer, default: 1
    change_column :annual_footprints, :input_home_users, :integer, default: 2



  end
end
