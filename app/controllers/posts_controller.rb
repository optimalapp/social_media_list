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
    @posts = Post.get_posts_by_dates(param_set[:start_date], param_set[:end_date])
    render "index"
  end

  def text_search
    @posts = Post.get_posts_by_text(param_set[:text_query])
    render "index"
  end

  private

  def posts_params
    params.require(:post).permit(:selection_name)[:selection_name]
  end

  def param_set
    params.permit(:start_date, :end_date, :text_query)
  end
end
