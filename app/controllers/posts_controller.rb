class PostsController < ApplicationController
  def index
    @posts = Post.all_posts
  end

  def network_sort
    @posts = Post.get_posts_by_network(posts_params)
    render "index"
  end

  def list_sort
    @posts = Post.get_posts_by_list(posts_params)
    render "index"
  end

  def date_range_sort
    @posts = Post.get_posts_by_dates(date_params[:start_date], date_params[:end_date])
    render "index"
  end

  private

  def posts_params
    params.require(:post).permit(:selection_name)[:selection_name]
  end

  def date_params
    params.permit(:start_date, :end_date)
  end
end
