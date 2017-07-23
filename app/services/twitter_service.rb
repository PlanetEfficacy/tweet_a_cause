class TwitterService
  attr_reader :user
  def initialize(user)
    @user = user
  end


  def fetch_tweets
    # client = client
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      # config.access_token = ENV['TWITTER_ACCESS_TOKEN']
      # config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
    debugger
  end
  private
  def client

  end
end
