class ChangeColumnsDefaultAnnualFootprints < ActiveRecord::Migration[7.0]
  def change
    change_column :annual_footprints, :input_transport_plane, :boolean, default: false
    change_column :annual_footprints, :input_transport_car, :boolean, default: false
    change_column :annual_footprints, :input_transport_train, :boolean, default: false
    change_column :annual_footprints, :input_transport_scooter_km, :integer, default: 0
  end
end
