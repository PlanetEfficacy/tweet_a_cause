require 'rails_helper'

RSpec.describe Preference, type: :model do
  describe "factory" do
    it "is valid" do
      expect(build :preference).to be_valid
    end
  end
  describe "associations" do
    it { should belong_to :user }
    it { should belong_to :charity }
  end
end
