class TwitterService
  attr_reader :user, :client


  def initialize(user)
    @user = user
    @client = user.client
  end

  def fetch_tweets
  end
end
