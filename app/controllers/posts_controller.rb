class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: %i[index show new]
  before_action :set_post, only: %i[show]

  def index
    @user = User.includes(posts: :comments).find(params[:user_id])
    @posts = @user.posts
    @comment = Comment.new
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
    @comments = @post.comments
    @like = Like.new
  end

  def new
    @post = Post.new
  end

  def create
    @user = current_user
    @post = @user.posts.new(post_params)
    if @post.save
      flash[:notice] = 'Post created successfully.'
      redirect_to user_post_path(@user, @post)
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def destroy
    @current_user = current_user
    @current_user.posts.destroy(params[:id])
    redirect_to user_posts_path(@user)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = @user.posts.includes(:comments).find_by_id(params[:id])
    return unless @post.nil?

    flash[:alert] = 'No post, back to posts page!!'
    redirect_to user_posts_path(@user)
  end
end
