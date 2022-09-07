class RenameCounterToTweetCounter < ActiveRecord::Migration[7.0]
  def change
    rename_table :counters, :tweet_counters
  end
end
