class CommentsController < ApplicationController
  load_and_authorize_resource

  before_action :find_post

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.new(comment_params.merge(post: @post))
   
    if @comment.save
      flash[:notice] = 'Comment created successfully.'
      redirect_to user_post_path(@post.author, @post)
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @user = @post.author
    @comment.destroy
    redirect_to user_post_path(@user, @post) if @post.save
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end
end
