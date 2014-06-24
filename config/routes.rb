Rails.application.routes.draw do
  root 'pages#welcome'

  get 'dashboard' => 'hackers#dashboard'
  get 'apply' => 'hackers#new'
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'
  get 'pages/welcome'
  get 'teams/join'
  get 'teams/leave'

  get 'my_team', to: 'teams#show'

  resources :applications
  resources :schools
  resources :hackers
  resources :teams, except: :show do
    get 'remove_hacker', on: :member
  end
  resources :sessions
  resources :password_resets
  resources :hacker_invitations
end
