Rails.application.routes.draw do
  root 'welcome#index'

  get '/users/:id' => 'users#show', as: 'users'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/about' => 'welcome#about'
  get '/contact' => 'welcome#contact'
  get '/bio' => 'welcome#bio'
  get '/projects' => 'welcome#projects'

  resources :blogs
  resources :articles
  resources :reports, only: [:index]

  resources :schools do
    resources :coordinators
    resources :teachers
    resources :speducators
    resources :students do
      resources :cards
      resources :bips do
        resources :goals
      end
    end
  end

  resources :observations, only: [:edit, :update, :show]

  get '/schools/:school_id/students/:id/team' => 'students#team', as: 'school_student_team'
  post '/schools/:school_id/students/:id/team' => 'students#add_member', as: 'school_student_team_add'
  delete '/schools/:school_id/students/:student_id/staff/:id' => 'students#remove_member', as: 'school_student_team_remove'

  resources :admins, only: [:show]

  namespace :api do
    namespace :v1 do
      post '/login' => "sessions#create"
      post '/loggedin' => "sessions#show"
      resources :observations, only: [:index, :update]
    end
  end
end
