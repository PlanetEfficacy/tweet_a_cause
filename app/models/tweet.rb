class Tweet < ApplicationRecord
  validates_presence_of :tweet_id
  validates_presence_of :date
  validates_uniqueness_of :tweet_id

  belongs_to :user
end
