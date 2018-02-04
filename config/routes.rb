Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', invitations: 'users/invitations'}

  root to: 'index#index'
  
  get '/directions', to: "index#directions"
  get '/membership', to: "index#membership"
  get '/research', to: "index#research"
  get '/schedule', to: "index#schedule"
  get '/about', to: "index#about"
  get '/user_manager', to: "index#manager"
  
  resources :index
  
  resources :database, only: [:index]
  
  resources :books
  
  resources :articles, only: [:index, :edit, :update, :new, :create, :destroy]
  
  resources :forums, only: [:edit, :update, :new, :create, :destroy]
  
end