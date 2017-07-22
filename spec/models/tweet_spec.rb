require 'rails_helper'

RSpec.describe Tweet, type: :model do
  describe "validations" do
    it { should validate_presence_of(:twitter_id) }
    it { should validate_presence_of(:date) }
    it { should validate_uniqueness_of(:twitter_id) }
  end
end
