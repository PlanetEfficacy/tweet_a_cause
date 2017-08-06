desc "This task calls a method on TweetDonationService to store new tweets"
task :store_tweets => :environment do
  puts "Storing new tweets for all users..."
  TweetDonationsService.store_new_tweets_for_all_users
  puts "done storing new tweets."
end

desc "This task calls a method on TweetDonationSErvice to create new donations"
task :create_donations => :environment do
  puts "Creating new donations for all users..."
  TweetDonationsService.create_donations_for_all_new_tweets
  puts "done creating donations."
end
