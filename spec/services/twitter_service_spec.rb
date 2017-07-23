require "rails_helper"

describe TwitterService do
  let!(:user) { double }
  let!(:client) { double }

  describe "#new" do
    it "is initialized with a user" do
      allow(user).to receive(:client).and_return(client)

      result = described_class.new(user)

      expect(result).to be_instance_of TwitterService
      expect(result.user).to eq user
      expect(result.client).to eq client
    end
  end

  describe "#fetch_tweets" do
    let!(:client) { double }
    it "fetches a user's tweets" do
      user.stub(:id) { 123456789 }

      client.should_receive(:user_timeline).with(123456789, trim_user: true).once

      described_class.new(user).fetch_tweets
    end
  end
end
