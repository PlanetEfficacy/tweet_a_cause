require 'rails_helper'

RSpec.describe Donation, type: :model do
  describe "factory" do
    it "is valid" do
      expect(build :donation).to be_valid
    end
  end
end
