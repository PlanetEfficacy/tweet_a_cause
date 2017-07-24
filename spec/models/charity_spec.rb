require 'rails_helper'

RSpec.describe Charity, type: :model do
  describe "factory" do
    it "is valid" do
      expect(build :charity).to be_valid
    end
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

  describe "associations" do
    it { should have_many :donations }
  end
end
