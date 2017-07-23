require 'spec_helper'

describe TweetDonationsService do
  describe "#store_new_tweets_for_all_users" do
    it "stores all new tweets for all users" do
      twitter_service1 = double
      twitter_service2 = double
      user = create :user
      alternate_user = create :alternate_user
      allow(TwitterService).to receive(:new).with(user).and_return(twitter_service1).once
      allow(TwitterService).to receive(:new).with(alternate_user).and_return(twitter_service2).once
      [twitter_service1, twitter_service2].each do |service|
        expect(service).to receive(:store_new_tweets).once
      end

      described_class.store_new_tweets_for_all_users
    end
  end

  describe "#create_donations_for_all_new_tweets" do

  end
end
