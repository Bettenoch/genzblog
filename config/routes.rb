Rails.application.routes.draw do
  devise_for :users
  get '/sign_out_user', to: 'users#sign_out_user', as: 'sign_out_user'
  get "up" => "rails/health#show", as: :rails_health_check
  
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new]
  end
  post '/users/:user_id/posts', to: 'posts#create', as: 'create_user_post'
  post '/users/:user_id/posts/:id/likes', to: 'likes#create', as: 'create_post_like'
  get '/posts/:post_id/comments/new', to: 'comments#new', as: 'new_post_comment'
  post '/posts/:post_id/comments', to: 'comments#create', as: 'create_post_comment'

  # Defines the root path route ("/")
  root "users#index"
end
