class ChangeColumnDefaultAnnualFootprints < ActiveRecord::Migration[7.0]
  def change
    change_column :annual_footprints, :input_transport_plane, :boolean, default: true
    change_column :annual_footprints, :input_transport_car, :boolean, default: true
    change_column :annual_footprints, :input_transport_train, :boolean, default: true
  end
end
