class CreateMeasurements < ActiveRecord::Migration[7.0]
  def change
    create_table :measurements do |t|
      t.string :title
      t.string :category
      t.float :kgCO2e
      t.text :source_description_html

      t.timestamps
    end
  end
end
