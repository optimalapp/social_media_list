class PostsController < ApplicationController
  def index
    @posts = Post.all_posts
  end

  def network_sort
    @posts = Post.get_posts_by_network(posts_params[:selection_name])
    render "index"
  end

  def list_sort
    @posts = Post.get_posts_by_list(posts_params[:selection_name])
    render "index"
  end

  private

  def posts_params
    params.require(:post).permit(:selection_name)
  end
end
