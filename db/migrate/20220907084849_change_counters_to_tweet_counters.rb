class ChangeCountersToTweetCounters < ActiveRecord::Migration[7.0]
  def change
    rename_column :tweet_counters, :tweet_count, :count
    remove_column :tweet_counters, :mail_count
  end
end
