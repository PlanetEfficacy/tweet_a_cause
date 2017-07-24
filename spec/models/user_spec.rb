require 'rails_helper'

RSpec.describe User, type: :model do
  describe "factory" do
    it "has is valid" do
      expect(build :user).to be_valid
      expect(build :alternate_user).to be_valid
    end
  end

  describe "associations" do
    it { should have_many :tweets }
    it { should have_many :preferences }
    it { should have_many :donations }
  end


  describe "#most_recent_tweet" do
    it "returns the users most recent tweet" do
      user = create :user
      tweet1 = create :tweet, user: user, tweet_id: 1, created_at: 1.day.ago
      tweet2 = create :tweet, user: user, tweet_id: 2, created_at: Time.now

      result = user.most_recent_tweet

      expect(result).to eq(tweet2)
    end
  end

  describe "#from_omniauth(auth)" do
    let!(:credentials) { { token: '123', secret: 'abc' } }
    let!(:info) { { email: 'jesse@example.com' } }
    let!(:auth) { { uid: '123456', provider: 'twitter', credentials: credentials, info: info } }

    it "creates a new user when no user is found" do
      expect(User.count).to eq 0
      result = User.from_omniauth(auth)

      expect(result).to be_instance_of(User)
      expect(result.uid).to eq '123456'
      expect(result.provider).to eq 'twitter'
      expect(result.email).to eq 'jesse@example.com'
      expect(result.twitter_token).to eq '123'
      expect(result.twitter_secret).to eq 'abc'
    end

    it "updates a user when a user is found" do
      user = create :user,
                    uid:            '123456',
                    provider:       'twitter',
                    email:          'jesse@example.com',
                    twitter_token:  '456',
                    twitter_secret: 'def'

      result = User.from_omniauth(auth)
      expect(User.count).to eq 1
      expect(result.id).to eq user.id
      expect(result.uid).to eq user.uid
      expect(result.provider).to eq user.provider
      expect(result.email).to eq user.email
      expect(result.twitter_token).to eq auth[:credentials][:token]
      expect(result.twitter_secret).to eq auth[:credentials][:secret]
    end
  end

  describe "#twitter_client" do
    it "establishes a connection with the twitter api using user token and secret" do
      user = create :user

      result = user.client

      expect(result.consumer_key).to eq ENV['TWITTER_CONSUMER_KEY']
      expect(result.consumer_secret).to eq ENV['TWITTER_CONSUMER_SECRET']
      expect(result.access_token).to eq user.twitter_token
      expect(result.access_token_secret).to eq user.twitter_secret
    end
  end

  describe "preference methods" do
    let!(:user) { create :user }
    let!(:charity) { create :charity }
    let!(:preference) { create :preference, user: user, charity: charity, amount: 10 }
    describe "#charity" do
      it "returns a users perferred charity" do
        expect(user.charity).to eq charity
      end
    end
    describe "#default_contribution" do
      it "returns a users perferred contribution level" do
        expect(user.default_contribution).to eq 10
      end
    end
  end
end
