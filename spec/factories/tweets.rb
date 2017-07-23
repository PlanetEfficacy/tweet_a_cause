FactoryGirl.define do
  factory :tweet do
    tweet_id "1234567890"
    date "2017-07-22 10:57:13"
    user
  end
end
