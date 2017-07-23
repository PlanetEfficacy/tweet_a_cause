require "rails_helper"

describe TwitterService do
  let!(:user) { create :user }
  let!(:client) { double }

  before(:each) do
    allow(user).to receive(:client).and_return(client)
  end

  describe "#new" do
    it "is initialized with a user" do
      result = described_class.new(user)

      expect(result).to be_instance_of TwitterService
      expect(result.user).to eq user
      expect(result.client).to eq client
    end
  end

  describe "#fetch_tweets" do

    before(:each) do
      allow(client).to receive(:user).and_return(user.uid)
    end

    context "when a user has no stored tweets" do
      it "fetches a user's tweets" do
        expect(client).to receive(:user_timeline).with(user.uid, count: 200, trim_user: true, since_id: nil).once

        described_class.new(user).fetch_tweets
      end
    end

    context "when a user has stored tweets" do
      it "fetches a user's tweet since the most recent stored tweet" do
        tweet = create :tweet, user: user
        expect(client).to receive(:user_timeline).with(user.uid, count: 200, trim_user: true, since_id: tweet.tweet_id)

        described_class.new(user).fetch_tweets
      end
    end
  end

  describe "#store_new_tweets" do
    let(:tweet) { double }
    let(:tweets) { [tweet] }
    let(:id) { '123456789' }
    let(:datetime) { 1.day.ago }

    it "stores a user's tweets" do
      twitter_service = described_class.new(user)
      allow(twitter_service).to receive(:fetch_tweets).and_return(tweets)
      allow(tweet).to receive(:id).and_return(id)
      allow(tweet).to receive(:created_at).and_return(datetime)

      result = twitter_service.store_new_tweets

      expect(Tweet.count).to eq 1
      expect(Tweet.first.tweet_id).to eq(id)
      expect(Tweet.first.date).to eq(datetime)
      expect(Tweet.first.user).to eq(user)
    end
  end

end
