class CreateAnnualFootprints < ActiveRecord::Migration[7.0]
  def change
    create_table :annual_footprints do |t|
      t.float :annual_footprint_kgCO2e

      t.timestamps
    end
  end
end
