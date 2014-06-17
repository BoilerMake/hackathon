Rails.application.routes.draw do
  get 'apply' => 'hackers#new'
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'
  get 'pages/welcome'
  root 'pages#welcome'

  resources :schools
  resources :hackers
  resources :sessions
  resources :password_resets

end
