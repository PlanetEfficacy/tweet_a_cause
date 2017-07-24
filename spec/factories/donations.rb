FactoryGirl.define do
  factory :donation do
    amount 1
    user
    tweet
    charity
  end
end
