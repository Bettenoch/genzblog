class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.first
    @current_user
  end
  # helper method
  helper_method :current_user
end
