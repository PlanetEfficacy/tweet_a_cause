class Tweet < ApplicationRecord
  validates_presence_of :twitter_id
  validates_presence_of :date
  validates_uniqueness_of :twitter_id
end
