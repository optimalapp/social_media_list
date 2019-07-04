class Post < ApplicationRecord
  belongs_to :account

  def self.all_posts
    posts = Post.all
    return_array(posts)
  end

  def self.get_posts_by_list(list_name)
    users = List.find_by(name: list_name).users
    posts = users.map { |user| user.accounts.map { |account| account.posts } }.flatten
    return_array(posts)
  end

  def self.get_posts_by_dates(start_date, end_date)
    posts = Post.where(date_posted: start_date..end_date)
    return_array(posts)
  end

  def self.get_posts_by_network(network_name)
    posts = Account.all.map { |a| a.social_network == network_name ? a.posts : nil }.flatten.compact
    return_array(posts)
  end

  private

  def self.return_array(posts)
    posts_array = []
    posts.each do |post|
      post_hash = {}
      post_hash[:date_posted] = post.date_posted
      post_hash[:social_network] = post.account.social_network
      post_hash[:link] = post.link
      post_hash[:name] = post.account.user.name
      post_hash[:list] = post.account.user.lists.map { |l| l.name }.join(", ")
      post_hash[:text] = post.text
      posts_array << post_hash
    end
    return posts_array
  end
end
