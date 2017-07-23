require 'rails_helper'

RSpec.describe User, type: :model do
  describe "factory" do
    it "has is valid" do
      expect(build :user).to be_valid
    end
  end

  describe "#from_omniauth(auth)" do
    let!(:credentials) { { token: '123', secret: 'abc' } }
    let!(:info) { { email: 'jesse@example.com' } }
    let!(:auth) { { uid: '123456', provider: 'twitter', credentials: credentials, info: info } }

    it "creates a new user when no user is found" do
      expect(User.count).to eq 0
      result = User.from_omniauth(auth)

      expect(result).to be_instance_of(User)
      expect(result.uid).to eq '123456'
      expect(result.provider).to eq 'twitter'
      expect(result.email).to eq 'jesse@example.com'
      expect(result.twitter_token).to eq '123'
      expect(result.twitter_secret).to eq 'abc'
    end

    it "updates a user when a user is found" do
      user = create :user,
                    uid:            '123456',
                    provider:       'twitter',
                    email:          'jesse@example.com',
                    twitter_token:  '456',
                    twitter_secret: 'def'

      result = User.from_omniauth(auth)
      expect(User.count).to eq 1
      expect(result.id).to eq user.id
      expect(result.uid).to eq user.uid
      expect(result.provider).to eq user.provider
      expect(result.email).to eq user.email
      expect(result.twitter_token).to eq auth[:credentials][:token]
      expect(result.twitter_secret).to eq auth[:credentials][:secret]
    end
  end
end
