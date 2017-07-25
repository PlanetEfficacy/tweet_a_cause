class TwitterService
  attr_reader :user, :client

  MAX_TWEET_COUNT = 200 # the max number of tweets we can retrieve with one query
  MIN_TWEET_COUNT = 1 # the min number of tweets we can retrieve with one query


  def initialize(user)
    @user = user
    @client = user.client
    @most_recent_tweet_id = user.most_recent_tweet.tweet_id if user.most_recent_tweet.present?
    @count = @most_recent_tweet_id.nil? ? MIN_TWEET_COUNT : MAX_TWEET_COUNT
  end

  def fetch_tweets
    options = {
      count: @count,
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
