Rails.application.routes.draw do
  root 'posts#index'

  resources :posts, only: [:index, :show, :create, :update, :destroy]
end
