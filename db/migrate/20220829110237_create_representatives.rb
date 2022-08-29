class CreateRepresentatives < ActiveRecord::Migration[7.0]
  def change
    create_table :representatives do |t|
      t.string :first_name
      t.string :last_name
      t.string :circo_key
      t.string :email
      t.string :twitter

      t.timestamps
    end
  end
end
