Rails.application.routes.draw do
   devise_for :users
  resources :users, except: :create

  # Name it however you want
  post 'create_user' => 'users#create', as: :create_user    
  root to: 'index#index'
  
  get '/directions', to: "index#directions"
  get '/membership', to: "index#membership"
  get '/research', to: "index#research"
  get '/schedule', to: "index#schedule"
  
  resources :books
end
