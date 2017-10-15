Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }


  root to: 'index#index'
  
  get '/directions', to: "index#directions"
  get '/membership', to: "index#membership"
  get '/research', to: "index#research"
  get '/schedule', to: "index#schedule"
  
  resources :books
  
end