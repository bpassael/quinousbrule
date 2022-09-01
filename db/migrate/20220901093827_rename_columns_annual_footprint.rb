class RenameColumnsAnnualFootprint < ActiveRecord::Migration[7.0]
  def change
    rename_column :annual_footprints, :input_transport_plane?, :input_transport_plane
    rename_column :annual_footprints, :input_transport_car?, :input_transport_car
    rename_column :annual_footprints, :input_transport_train?, :input_transport_train
    rename_column :annual_footprints, :input_home_old?, :input_home_old
    rename_column :annual_footprints, :input_food_bottled_water?, :input_food_bottled_water
  end
end
