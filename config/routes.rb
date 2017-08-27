Rails.application.routes.draw do
  root to: 'index#index'
  
  get '/directions', to: "index#directions"
end
