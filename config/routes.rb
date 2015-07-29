Rails.application.routes.draw do
  root 'pages#welcome'

  get 'dashboard' => 'hackers#dashboard'
  get 'apply' => 'hackers#new'
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'
  get 'pages/welcome'

  get 'execs/dashboard'
  get 'execs/sticker_recipients'
  get 'execs/hackers_for'
  get 'execs/export'
  get 'execs/shirts' => 'execs#shirts'

  resources :interest_signups, only: [:create]
  resources :updates, only: [:index, :new, :create]
  get 'confirm', to: 'hackers#confirm'

  get 'schools/export'

  resources :schools
  resources :hackers, except: [:index, :destroy]

  resources :sessions
  resources :password_resets

  get 'slack_integrations/applicants'

end
