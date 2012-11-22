Clips::Application.routes.draw do
  root to: 'clips#new'

  resources :clips
end
