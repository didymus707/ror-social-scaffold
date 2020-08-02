Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show] do
    resources :friendships, only: [:create] do
      collection do
        get 'accept_request'
        get 'decline_request'
      end
    end
  end
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :post_likes, only: [:create, :destroy]
  end
  resources :comments, only: [:create] do
    resources :comment_likes, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
