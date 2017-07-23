require "rails_helper"

describe TwitterService do
  let!(:user) { double }
  describe "#new" do
    it "is initialized with a username" do
      expect(described_class.new(user)).to be_instance_of TwitterService
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
