Rails.application.routes.draw do
  root 'pages#welcome'

  get 'dashboard' => 'hackers#dashboard'
  get 'apply' => 'hackers#new'
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'
  get 'pages/welcome'
  get 'teams/join'
  get 'teams/leave'
  get 'execs/applied' => 'execs#applied'

  get 'my_team', to: 'teams#show'

  get 'schools/index'

  resources :hackers, except: [:index]
  resources :teams, except: [:show, :index, :destroy]  do
    get 'remove_hacker', on: :member
  end
  resources :sessions
  resources :password_resets
  resources :hacker_invitations
end
