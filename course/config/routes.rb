Rails.application.routes.draw do
  get 'dashboard', to: 'dashboard#index', as: :dashboard
  get "staticpages/terms"
  get "staticpages/privacy"
  
  devise_for :users, controllers: {
    registrations: 'users/registrations'
    # Removed omniauth_callbacks for now
  }

  # Firebase Authentication routes
  namespace :firebase do
    post 'auth', to: 'auth#auth'
    post 'link', to: 'auth#link_account'
  end

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
  resources :courses do
    member do
      post 'enroll'
      delete 'unenroll'
    end
  end
  resources :tests
end