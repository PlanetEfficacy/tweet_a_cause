class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
        #  :recoverable, :rememberable, :trackable, :validatable,
        #  :confirmable, :timeoutable, :lockable, :omniauthable, :omniauth_providers => [:twitter]

  devise :trackable, :omniauthable,
         omniauth_providers: [:twitter]

  class << self
    def from_omniauth(auth)
      user = where(provider: auth[:provider], uid: auth[:uid]).first_or_create do |user|
        user.email =          auth[:info][:email]
        user.provider =       auth[:provider]
        user.uid =            auth[:uid]
        user.twitter_token =  auth[:credentials][:token]
        user.twitter_secret = auth[:credentials][:secret]
        user.save!
      end

      reconcile_twitter_token_and_secret(user, auth)
    end

    private
    def reconcile_twitter_token_and_secret(user, auth)
      unless token_and_secret_are_already_stored?(user, auth)
        user.twitter_token =  auth[:credentials][:token]
        user.twitter_secret = auth[:credentials][:secret]
        user.save!
      end
      user
    end

    def token_and_secret_are_already_stored?(user, auth)
      user.twitter_token == auth[:credentials][:token] && user.twitter_secret == auth[:credentials][:secret]
    end
  end
end
