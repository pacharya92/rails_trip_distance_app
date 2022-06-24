Rails.application.routes.draw do

  root to: redirect('/sign_in')

  resources :users, only: [:new, :create]
  resources :locations
  resources :trips do 
    collection do 
      get :governing_district
    end
  end

  get '/welcome', to: 'sessions#welcome'

  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'

  get '/trip', to: 'trips#new'
  get '/show_trip', to: 'trips#show'
  post '/create_trip', to: 'trips#create'


  get '/sign_up', to: 'registrations#new'
  post '/sign_up', to: 'registrations#create'

  delete 'logout', to: 'sessions#destroy'


end
