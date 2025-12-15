Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Auth pages
  get '/login', to: 'auth#login'
  get '/signup', to: 'auth#signup'
  get '/profile', to: 'auth#profile'
  post '/logout', to: 'auth#logout'

  root 'tests#index'
  get '/tests', to: 'tests#index'
  get '/tests/:id', to: 'tests#show'
  post '/attempts', to: 'attempts#create'
  get '/results', to: 'results#index'
  post '/recommend_reward', to: 'bandit_integration#reward'
end
