class PostsController < ApplicationController
  before_action :find_user, only: %i[index show]
  before_action :find_post, only: [:show]

  def index
    @posts = @user.posts
  end

  def show
    # set in the before_actions
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'User not found'
    redirect_to users_path
  end

  def find_post
    @post = @user.posts.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Post not found'
    redirect_to user_posts_path(@user)
  end
end
