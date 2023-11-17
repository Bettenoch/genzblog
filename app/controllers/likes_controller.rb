class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = Like.new(user_id: current_user.id, post_id: @post.id)
    if @like.save
      redirect_to user_post_path(@like.post.author_id, @like.post)
    else
      @post = Post.find(params[:id])
      redirect_to user_post_path(@post.author_id, @post), notice: 'could not save like'
    end
  end
end
