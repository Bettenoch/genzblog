class PostsController < ApplicationController
  before_action :set_user, only: [:index, :show]
  before_action :set_post, only: [:show]

  def index
    @posts = @user.posts
  end

  def show
    @comments = @post.comments
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = @user.posts.find_by_id(params[:id])
  end
end
