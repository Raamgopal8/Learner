Rails.application.routes.draw do
  root 'tests#index'
  get '/tests', to: 'tests#index'
  get '/tests/:id', to: 'tests#show'
  post '/attempts', to: 'attempts#create'
  get '/results', to: 'results#index'
end
