class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # first user

  def update_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :email, :bio, :photo, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :email, :bio, :photo, :password, :current_password)
    end
  end
end
