class AddMoreDefaultColumns < ActiveRecord::Migration[7.0]
  def change
    change_column :annual_footprints, :input_transport_car_passengers, :integer, default: 1
    change_column :annual_footprints, :input_transport_bus_hours_week, :integer, default: 3
    change_column :annual_footprints, :input_transport_metro_tram_hours_week, :integer, default: 3

  end
end
