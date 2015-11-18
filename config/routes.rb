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
    resources :students do
      resources :cards
    end
  end

  get '/schools/:school_id/students/:id/team' => 'students#team', as: 'school_student_team'
  post '/schools/:school_id/students/:id/team' => 'students#add_member', as: 'school_student_team_add'
  delete '/schools/:school_id/students/:student_id/staff/:id' => 'students#remove_member', as: 'school_student_team_remove'

  resources :admins, only: [:show]
end
