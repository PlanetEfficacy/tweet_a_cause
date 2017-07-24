class Charity < ApplicationRecord
  has_many :donations
  validates_presence_of :name
  validates_uniqueness_of :name

end
