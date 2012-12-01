Clips::Application.routes.draw do
  get "welcom/index"

  root to: 'clips#new'

  resources :clips

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destory', as: 'signout'
end
