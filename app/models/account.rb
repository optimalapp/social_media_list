class Account < ApplicationRecord
  has_many :posts
  belongs_to :user

  def self.all_networks
    Account.all.map { |a| a.social_network }.uniq
  end
end
