require 'rails_helper'

RSpec.describe Donation, type: :model do
  describe "factory" do
    it "is valid" do
      expect(build :donation).to be_valid
    end
  end

  describe "validations" do
    it { validate_numericality_of :amount }
  end

  describe "associations" do
    it { should belong_to :tweet }
    it { should belong_to :user }
    it { should belong_to :charity }
  end

  describe "defaults" do
    it "is created with complete set to false" do
      subject = build :donation
      expect(subject.complete).to eq false
    end
  end

  describe "#complete?" do
    context "the donation is complete" do
      it "returns true" do
        subject = build :donation, complete: true
        expect(subject.complete?).to eq true
      end
    end

    context "the donation is not complete" do
      it "returns false" do
        subject = build :donation
        expect(subject.complete?).to eq false
      end
    end
  end

  describe "scope: incomplete" do
    it "returns incomplete donations" do
      user = create :user
      charity = create :charity
      tweet = create :tweet, user: user
      tweet2 = create :tweet, tweet_id: '987654321', user: user
      donation1 = create :donation, complete: false, user: user, tweet: tweet, charity: charity
      donation2 = create :donation, complete: true, user: user, tweet: tweet2, charity: charity

      result = Donation.incomplete

      expect(result.size).to eq 1
      expect(result.first).to eq donation1
    end
  end
end
