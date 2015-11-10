Rails.application.routes.draw do

  get 'admins/show'

  get 'admin/show'

  root 'welcome#index'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/admins/:id' => 'admins#show'
end
