require "rails_helper"

describe TwitterService do
  describe "#new" do
    let!(:user) { double }
    it "is initialized with a username" do
      expect(described_class.new(user)).to be_instance_of TwitterService
    end
  end
end
