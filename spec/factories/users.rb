FactoryGirl.define do
  factory :user do
    id 123456789
    uid 987654321
    email 'jesse@example.com'
    twitter_token 1111111111
    twitter_secret 2222222222

    factory :alternate_user do
      id 234567890
      uid 876543210
      email 'another_user@example.com'
      twitter_token 2222222222
      twitter_secret 1111111111
    end
  end
end
