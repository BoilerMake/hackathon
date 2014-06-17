Rails.application.routes.draw do
  resources :schools

  get 'pages/welcome'

  resources :hackers
  get 'apply' => 'hackers#new'
  get 'login' => 'sessions#new'

  root 'pages#welcome'
end
