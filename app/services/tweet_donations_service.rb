class TweetDonationsService
  class << self
    def store_new_tweets_for_all_users
      User.all.each do |user|
        TwitterService.new(user).store_new_tweets
      end
    end

    def create_donations_for_all_new_tweets
      User.all.each do |user|
        DonationService.new(user).create_donations
      end
    end
  end
end
