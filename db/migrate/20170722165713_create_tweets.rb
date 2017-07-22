class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.string :twitter_id
      t.datetime :date

      t.timestamps
    end
  end
end
