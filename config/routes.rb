Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "welcome#home"

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'

  get '/auth/facebook/callback' => 'sessions#create'

  resources :event_guests

  resources :users do
    resources :events
  end



end
