require "rails_helper"

describe DonationService do
  let!(:user) { create :user }
  let!(:charity) { create :charity }
  let!(:preference) { create :preference, user: user, charity: charity }
  let!(:tweet) { create :tweet }

  describe "#new" do
    it "is initialized with a user" do
      result = described_class.new(user)

      expect(result).to be_instance_of DonationService
      expect(result.user).to eq user
      expect(result.charity).to eq charity
    end
  end

  describe "#fetch_tweets_without_donations" do
    context "when all tweets have donations" do
      it "returns empty array" do
        create :donation, user: user, charity: charity, tweet: tweet
        donation_service = described_class.new(user)
        result = donation_service.fetch_tweets_without_donations

        expect(result).to be_empty
      end
    end

    context "when all tweets do not have donations" do
      it "fetches a users tweets without donations" do
        donation_service = described_class.new(user)
        result = donation_service.fetch_tweets_without_donations

        expect(result).to eq Tweet.where(id: tweet.id)
      end
    end
  end

  describe "#create_donations" do
    it "creates a donation for user's tweets without associated donations" do
      donation_service = described_class.new(user)
      donation_service.create_donations

      expect(Donation.count).to eq 1
      expect(Donation.first.tweet).to eq tweet
      expect(Donation.first.user).to eq user
      expect(Donation.first.charity).to eq charity
    end
  end

end
