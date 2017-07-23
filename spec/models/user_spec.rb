require 'rails_helper'

RSpec.describe User, type: :model do
  describe "factory" do
    it "has is valid" do
      expect(build :user).to be_valid
    end
  end
end
