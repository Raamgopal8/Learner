Rails.application.routes.draw do
  get "staticpages/terms"
  get "staticpages/privacy"
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'devise/sessions'
    # Removed omniauth_callbacks for now
  }

  # Custom routes for static pages
  get 'terms', to: 'staticpages#terms'  # Fixed controller name to match the generated one
  get 'privacy', to: 'staticpages#privacy'  # Fixed controller name to match the generated one

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
end