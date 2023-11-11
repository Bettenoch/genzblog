class PostsController < ApplicationController
  before_action :set_user, only: %i[index show]
  before_action :set_post, only: %i[show]

  def index
    @posts = @user.posts
    @comment = Comment.new
  end

  def show
    @comments = @post.comments
    @like = Like.new
  end

  def new
    # @user = current_user
    @post = Post.new
  end

  # def like
  #   @like = @post.likes.new(user: current_user)
  #   if @like.save
  #     redirect_to user_post_path(@user, @post)
  #   else
  #     redirect_to user_post_path(@user, @post), alert: 'Failed to like the post.'
  #   end
  # end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:notice] = 'Post created successfully.'
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = @user.posts.find_by_id(params[:id])
    return unless @post.nil?

    flash[:alert] = 'No post, back to posts page!!'
    redirect_to user_posts_path(@user)
  end
end
