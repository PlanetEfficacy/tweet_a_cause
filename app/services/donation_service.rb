class DonationService
  attr_reader :user, :charity


  def initialize(user)
    @user = user
    @charity = user.charity
  end

  def fetch_tweets_without_donations
    return user.tweets if user.donations.empty?
    tweets = user.tweets.where("tweets.id NOT IN (?)", user.donations.pluck(:tweet_id))
    Rails.logger.warn "User:#{user.id} has #{tweets.size} tweets without donations."
    tweets
  end

  def create_donations
    fetch_tweets_without_donations.each do |tweet|
      donation = Donation.new
      donation.user = user
      donation.tweet = tweet
      donation.charity = charity
      donation.amount = user.default_contribution
      donation.save!
      Rails.logger.warn "User:#{user.id} donation: #{donation.id} for amount: #{donation.amount} to charity: #{charity.id}"
    end
  end

end
