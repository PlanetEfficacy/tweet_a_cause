class TwitterService
  attr_reader :user, :client


  def initialize(user)
    @user = user
    @client = user.client
  end

  def fetch_tweets(count: 200)
    client.user_timeline(client.user, count: count, trim_user: true)
  end
end
