class Donation < ApplicationRecord
  belongs_to :tweet
  belongs_to :user
  belongs_to :charity
end
