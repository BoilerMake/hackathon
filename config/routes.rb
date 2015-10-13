Rails.application.routes.draw do
  root 'pages#welcome'

  get 'dashboard' => 'hackers#dashboard'
  get 'apply' => 'hackers#new'
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'
  get 'pages/welcome'

  get 'sponsors/resume_portal'
  get 'sponsors/hackers'

  get 'execs/dashboard'
  get 'execs/sticker_recipients'
  get 'execs/hackers_for'
  get 'execs/incomplete_hackers'
  get 'execs/export'
  get 'execs/transportation'
  get 'execs/shirts' => 'execs#shirts'

  get 'execs/school_groups'
  get 'execs/undecided_applications'
  get 'execs/school/:school_id' => 'execs#school_applications'

  get 'execs/ranker'
  get 'execs/hacker_detail/:hacker_id' => 'execs#hacker_detail'
  post 'execs/decision_submission'

  get  'execs/checkin'
  get  'execs/hacker_checkin_info'
  post 'execs/checkin' => 'execs#checkin_hacker', :defaults => { :format => 'json' }
  post 'execs/checkin/query' => 'execs#user_query'

  get 'visualization' => 'visualization#index'
  resources :interest_signups, only: [:create]
  resources :updates, only: [:index, :new, :create]
  get 'confirm', to: 'hackers#confirm'
  get 'decline', to: 'hackers#decline'

  get 'schools/export'

  resources :schools
  resources :hackers, except: [:destroy, :create]

  resources :hacker_rankings
  resources :sessions
  resources :password_resets

  get 'slack_integrations/applicants'
  get 'slack_integrations/hackers'

end
