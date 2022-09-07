class CreateCounters < ActiveRecord::Migration[7.0]
  def change
    create_table :counters do |t|
      t.integer :tweet_count
      t.integer :mail_count

      t.timestamps
    end
  end
end
