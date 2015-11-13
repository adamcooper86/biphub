Rails.application.routes.draw do
  root 'welcome#index'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  get '/users/:id' => 'users#show'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  resources :schools do
    resources :coordinators
    resources :teachers
    resources :speducators
  end

  resources :admins, only: [:show]
end
