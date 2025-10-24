Rails.application.routes.draw do
  devise_for :users
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

  # Enrollment route
  post 'enroll/:course_id', to: 'enrollments#create', as: 'enroll_course'

  # Catch-all route for any undefined routes (optional)
  # match '*path', to: 'home#index', via: :all
end