Clips::Application.routes.draw do
  root to: 'welcom#index'

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destory', as: 'signout'

  match "welcome", to: 'welcom#index', as: 'welcome'

  # this routes must be lowest position
  resources :clips, path: ":group_name"
end
