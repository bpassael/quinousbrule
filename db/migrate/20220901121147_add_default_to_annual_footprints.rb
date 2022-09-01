class AddDefaultToAnnualFootprints < ActiveRecord::Migration[7.0]
  def change
    change_column :annual_footprints, :input_transport_plane, :boolean, default: true
    change_column :annual_footprints, :input_transport_flights_short, :float, default: 1
    change_column :annual_footprints, :input_transport_flights_middle, :float, default: 1
    change_column :annual_footprints, :input_transport_flights_long, :float, default: 0
  end
end
