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
    resources :students
  end

  get '/schools/:school_id/students/:id/team' => 'students#team', as: 'school_student_team'
  post '/schools/:school_id/students/:id/team' => 'students#team', as: 'school_student_team_add'
  delete '/schools/:school_id/students/:id/team' => 'students#team', as: 'school_student_team_remove'

  resources :admins, only: [:show]
end
