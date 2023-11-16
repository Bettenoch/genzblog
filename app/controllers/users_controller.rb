class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @users = User.all
  end

  def show
    @posts = @user.top_three_recent_posts
  end

  def user_sign_out
    sign_out(current_user)
    redirect_to root_path, notice: 'Signed out successfully'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
