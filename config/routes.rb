Rails.application.routes.draw do
  devise_for :users
  
  namespace :api do
    post :auth, to: 'auth#create'
    resources :users, only: [] do
      resources :posts, only: [:index] do
        resources :comments, only: [:index, :create]
      end
    end
  end
  get "up" => "rails/health#show", as: :rails_health_check
  
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create]
    end
  end

  # Defines the root path route ("/")
  root "users#index"


  
end
