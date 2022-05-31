Rails.application.routes.draw do

  root 'sessions#welcome'

  resources :users, only: [:new, :create]

  get '/welcome', to: 'sessions#welcome'

  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'

  get '/sign_up', to: 'registrations#new'
  post '/sign_up', to: 'registrations#create'

  delete 'logout', to: 'sessions#destroy'


end
