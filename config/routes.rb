Rails.application.routes.draw do

  root 'sessions#welcome'

  resources :users, only: [:new, :create]
  resources :trips, only: [:new, :create]
  resources :locations

  get '/welcome', to: 'sessions#welcome'

  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'

  get '/trip', to: 'trips#new'
  post '/create_trip', to: 'trips#create'
  get '/show_trip', to: 'trips#show'

  get '/sign_up', to: 'registrations#new'
  post '/sign_up', to: 'registrations#create'

  delete 'logout', to: 'sessions#destroy'


end
