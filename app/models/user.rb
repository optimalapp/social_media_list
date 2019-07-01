class User < ApplicationRecord
  has_many :accounts
  has_and_belongs_to_many :lists
end
