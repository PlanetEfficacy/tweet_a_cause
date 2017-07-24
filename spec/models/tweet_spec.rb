require 'rails_helper'

RSpec.describe Tweet, type: :model do
  describe "validations" do
    it { should validate_presence_of(:tweet_id) }
    it { should validate_presence_of(:date) }
    it { should validate_uniqueness_of(:tweet_id) }
  end

  describe "associations" do
    it { should belong_to :user }
  end

  describe "factory" do
    it "is valid" do
      expect(build :tweet, user: (create :user)).to be_valid
    end
  end
end
