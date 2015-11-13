Rails.application.routes.draw do
  get 'teacher/new'

  get 'teacher/edit'

  get 'teacher/show'

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
  end

  resources :admins, only: [:show]
end
