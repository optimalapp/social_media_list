class List < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  has_and_belongs_to_many :users
  def self.all_lists
    List.all.map { |a| a.name }.uniq
  end

  private
end
