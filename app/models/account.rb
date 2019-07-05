class Account < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  has_many :posts
  belongs_to :user

  def self.all_networks
    Account.all.map { |a| a.social_network }.uniq
  end
end
