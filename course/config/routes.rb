Rails.application.routes.draw do
  # Root route
  root "home#index"

  # Static pages
  get "home/index"
  get "about", to: "home#about"
  get "login", to: "home#login"
  get "signup", to: "home#signup"

  # Resources
  resources :courses
  resources :tests

  # Catch-all route for any undefined routes (optional)
  # match '*path', to: 'home#index', via: :all
end