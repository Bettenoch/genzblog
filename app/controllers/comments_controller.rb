class CommentsController < ApplicationController
  before_action :set_user
  before_action :set_post

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = params[:post_id]
    if @comment.save
      flash[:notice] = 'Comment created successfully.'
      redirect_to user_post_path(@comment.post.author, @comment.post)
    else
      @post = Post.find(params[:post_id])
      redirect_to user_post_path(@post.author, @post), notice: 'comment created successfully'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def set_user
    @user = current_user
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
