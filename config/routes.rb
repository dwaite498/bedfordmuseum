Rails.application.routes.draw do
  post 'users/:user_id/renew', to: "users#renew", as: :renew_user

  get 'users/', to: "users#index"

  post 'users/:user_id/deactivate', to: "users#deactivate", as: :deactivate_user
  

  devise_for :users, controllers: { registrations: 'users/registrations', invitations: 'users/invitations'}
  
  get 'users/:user_id', to: "users#show", as: :show_user

  root to: 'index#index'
  
  get '/directions', to: "index#directions"
  get '/membership', to: "index#membership"
  get '/research', to: "index#research"
  get '/schedule', to: "index#schedule"
  get '/about', to: "index#about"
  
  resources :index
  
  resources :database, only: [:index]
  
  resources :books
  
  resources :articles, only: [:index, :edit, :update, :new, :create, :destroy]
  
  resources :forums, only: [:edit, :update, :new, :create, :destroy]
  
end