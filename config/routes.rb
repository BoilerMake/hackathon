Rails.application.routes.draw do
  get 'dashboard' => 'hackers#dashboard'
  get 'apply' => 'hackers#new'
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'
  get 'pages/welcome'
  root 'pages#welcome'


  resources :applications
  resources :schools
  resources :hackers
  resources :teams
  resources :sessions
  resources :password_resets

end
