class Post < ApplicationRecord
  after_create :set_user_id
  belongs_to :account
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  def self.all_posts
    posts = self.search({ "size": 10000,
                          "query": { "match_all": {} } })

    return_posts_array(posts)
  end

  def self.get_posts_by_list(list_name)
    lists = List.search({ "size": 10000, "query": { "match": {
      "name": list_name,
    } } })

    posts = []
    lists.each do |list|
      user_ids = list.usr_ids.scan(/\d+/).map(&:to_i)
      user_ids.each do |id|
        accounts = get_user_account(id)
        accounts.each { |account| get_posts(account.id.to_i).each { |p| posts << p } }
      end
    end
    return_posts_array(posts.flatten)
  end

  def self.get_posts_by_dates(start_date, end_date)
    start_date = Time.parse(start_date)
    end_date = Time.parse(end_date)
    posts = self.search({ "size": 10000,
                         "query": {
      "range": {
        "date_posted": {
          "gte": start_date,
          "lte": end_date,
          "boost": 2.0,
        },
      },
    } })
    return_posts_array(posts).sort_by { |h| h[:zip] }
  end

  def self.get_posts_by_network(network_name)
    accounts = Account.search({ "size": 10000, "query": { "match": {
      "social_network": network_name,
    } } })
    posts = accounts.map { |account| get_posts(account.id.to_i).map { |p| p } }.flatten
    return_posts_array(posts)
  end

  def self.get_posts_by_text(query)
    posts = self.search({
      "size": 10000,
      "query": {
        "match_phrase": { "text": query },
      },
    })
    return_posts_array(posts)
  end

  private

  def self.return_posts_array(posts)
    posts_array = []
    posts.each do |post|
      account_id = post.account_id.to_i
      next if account_id == 0
      account = get_account(account_id).first
      user = get_user(account.user_id).first
      post_hash = {}
      post_hash[:date_posted] = Time.parse(post.date_posted).strftime("%Y-%m-%d %H:%M")
      post_hash[:social_network] = account.social_network
      post_hash[:link] = post.link
      post_hash[:name] = get_user(account.user_id).first.name
      post_hash[:list] = get_list(user.id.to_i)
      post_hash[:text] = post.text
      posts_array << post_hash
    end
    posts_array
  end

  def self.get_user_account(user_id)
    Account.search({
      "size": 10,
      "query": {
        "term": { "user_id": user_id },
      },
    })
  end

  def self.get_account(id)
    query(Account, id)
  end

  def self.get_user(id)
    query(User, id)
  end

  def self.get_list(id)
    lists = List.search({ "size": 10000, "query": { "term": {
      "usr_ids": id,
    } } })
    lists.map { |l| l.name }.join(", ")
  end

  def self.get_posts(id)
    self.search({ "size": 10000, "query": { "term": {
      "account_id": id,
    } } })
  end

  def self.query(object, id)
    object.search({
      "size": 10,
      "query": {
        "term": { "id": id },
      },
    })
  end

  def set_user_id
    self.account.user.lists.map { |list| list.users.map { |user| list.usr_ids.include?(user.id.to_s) ? nil : list.update(usr_ids: list.usr_ids + "/" + user.id.to_s) } }
  end
end
