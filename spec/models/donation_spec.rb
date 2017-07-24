require 'rails_helper'

RSpec.describe Donation, type: :model do
  describe "factory" do
    it "is valid" do
      expect(build :donation).to be_valid
    end

    describe "validations" do
      it { validate_numericality_of :amount }
    end

    describe "associations" do
      it { should belong_to :tweet }
      it { should belong_to :user }
      it { should belong_to :charity }
    end
  end
end
