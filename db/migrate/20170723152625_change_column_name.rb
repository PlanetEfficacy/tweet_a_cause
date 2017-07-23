class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :tweets, :twitter_id, :tweet_id
  end
end
