require 'spec_helper'

describe TweetDonationsService do
  describe "#store_new_tweets_for_all_users" do
    it "stores all new tweets for all users" do
      user = create :user
      user2 = create :alternate_user
      allow(TwitterService).to receive(:new).with(:user).once
    end
  end

  describe "#create_donations_for_all_new_tweets" do

  end
end
