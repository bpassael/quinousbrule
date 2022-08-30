class AddColumnsToMeasurements < ActiveRecord::Migration[7.0]
  def change
    remove_column :measurements, :category
    remove_column :measurements, :source_description_html
    add_column :measurements, :eq_minutes_flight_jet_bollore, :float
    add_column :measurements, :eq_km_yacht_arnault, :float
    add_column :measurements, :additional_info, :string
    add_column :measurements, :source_link, :string
    add_column :measurements, :source_name, :string
    rename_column :measurements, :kgCO2e, :kgCO2e_year

  end
end
