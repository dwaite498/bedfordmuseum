Rails.application.routes.draw do
  devise_for :admins
  root 'index#index'
  
  get '/directions', to: 'index#directions'
  get '/membership', to: 'index#membership'
  get '/research', to: 'index#research'
  get '/schedule', to: 'index#schedule'
  get '/about', to: 'index#about'
  
  resources :books
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
