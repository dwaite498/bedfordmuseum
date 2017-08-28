Rails.application.routes.draw do
  root to: 'index#index'
  
  get '/directions', to: "index#directions"
  get '/membership', to: "index#membership"
  get '/research', to: "index#research"
  get '/schedule', to: "index#schedule"
end
