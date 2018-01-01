Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/nearest_gas', to: 'nearest_gas#challenge'
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
