require "rails_helper"

describe TwitterService do
  let!(:user) { double }
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
    it "fetches a user's tweets" do
      client.should_receive(:user).and_return(user)
      client.should_receive(:user_timeline).with(user, count: 200, trim_user: true).once

      result = described_class.new(user).fetch_tweets
    end
  end

end
