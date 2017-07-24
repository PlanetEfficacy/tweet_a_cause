class DonationService
  attr_reader :user, :charity


  def initialize(user)
    @user = user
    @charity = user.client
    @most_recent_tweet_id = user.most_recent_tweet.tweet_id if user.most_recent_tweet.present?
  end

  def fetch_tweets(count: 200)
    options = {
      count: count,
      trim_user: true,
      since_id: @most_recent_tweet_id
    }
    client.user_timeline(client.user, options)
  end

  def store_new_tweets
    fetch_tweets.each do |t|
      tweet             = Tweet.new
      tweet.tweet_id    = t.id
      tweet.date        = t.created_at
      tweet.user        = user
      tweet.save!
    end
  end

end
