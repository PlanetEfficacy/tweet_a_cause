class TweetDonationsService
  class << self
    def store_new_tweets_for_all_users
      User.all.each do |user|
        TwitterService.new(user).store_new_tweets
      end
    end
  end
end
