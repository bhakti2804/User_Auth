Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'users#index'
  get '/login' => 'users#index'
  post '/sessions' => 'sessions#create'
  get '/signup' => 'users#signup'
  post '/users' => 'users#create'
  get '/welcome/:id' => 'sessions#welcome'
  get '/logout' => 'sessions#destroy'
end
