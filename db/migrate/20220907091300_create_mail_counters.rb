class CreateMailCounters < ActiveRecord::Migration[7.0]
  def change
    create_table :mail_counters do |t|
      t.integer :count

      t.timestamps
    end
  end
end
