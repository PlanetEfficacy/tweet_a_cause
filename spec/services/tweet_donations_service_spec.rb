require 'spec_helper'

describe TweetDonationsService do
  let!(:user) { create :user }
  let!(:alternate_user) { create :alternate_user }
  describe "#store_new_tweets_for_all_users" do
    it "calls TwitterService.store_new_tweets for each user" do
      twitter_service1 = double
      twitter_service2 = double
      allow(TwitterService).to receive(:new).with(user).and_return(twitter_service1).once
      allow(TwitterService).to receive(:new).with(alternate_user).and_return(twitter_service2).once
      [twitter_service1, twitter_service2].each do |service|
        expect(service).to receive(:store_new_tweets).once
      end

      described_class.store_new_tweets_for_all_users
    end
  end

  describe "#create_donations_for_all_new_tweets" do
    xit "calls DonationService.create_new_donations for each tweet" do
      donation_service1 = double
      donation_service2 = double
      allow(DonationService).to receive(:new).with(user).and_return(donation_service1).once
      allow(DonationService).to receive(:new).with(alternate_user).and_return(donation_service1).once
      [donation_service1, donation_service2].each do |service|
        expect(service).to receive(:create_donations_for_all_new_tweets).once
      end
    end
  end
end
