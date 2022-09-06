class ChangeWaterColumnAnnualFootprint < ActiveRecord::Migration[7.0]
  def change
    change_column :annual_footprints, :input_food_bottled_water, :boolean, default: false
  end
end
