class ChangeColumnsAnnualComp < ActiveRecord::Migration[7.0]
  def change
    add_column :annual_footprints, :input_food_bottled_water?, :boolean
    remove_column :annual_footprints, :input_home_low_cons?
  end
end
