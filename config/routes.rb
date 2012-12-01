Clips::Application.routes.draw do
  root to: 'clips#new'

  resources :clips

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destory', as: 'signout'

  match "welcome", to: 'welcom#index', as: 'welcome'
end
