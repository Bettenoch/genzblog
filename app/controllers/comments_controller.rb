class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
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
end
