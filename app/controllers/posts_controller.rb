class PostsController < ApplicationController
  def index
    @posts = Post.all_posts
  end
end
