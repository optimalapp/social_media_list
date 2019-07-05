class User < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  has_many :accounts
  has_and_belongs_to_many :lists
end
