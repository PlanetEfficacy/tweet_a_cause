class TwitterService
  attr_reader :user, :client


  def initialize(user)
    @user = user
    @client = user.client
  end

  def fetch_tweets(count: 200)
    client.user_timeline(client.user, count: count, trim_user: true)
  end

  def store_new_tweets
    tweets = fetch_tweets
    tweets.each do |t|
      tweet = Tweet.new
      tweet.twitter_id = t.id
      tweet.date = t.created_at
      tweet.save!
    end
  end
  
end
