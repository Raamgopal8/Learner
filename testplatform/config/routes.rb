Rails.application.routes.draw do
  root 'tests#index'
  resources :tests, only: [:index, :show]
  resources :attempts, only: [:create]

  namespace :api do
    resources :tests, only: [] do
      resources :questions, only: [:index]
    end
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end