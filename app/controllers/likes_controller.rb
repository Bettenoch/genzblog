class LikesController < ApplicationController
    def create
      @like = current_user.likes.new
      @like.post_id = params[:id]
      if @like.save
        redirect_to user_post_path(@like.post.author_id, @like.post)
      else
        @post = Post.find(params[:id])
        redirect_to user_post_path(@post.author_id, @post), notice: 'could not save like'
      end
    end
end