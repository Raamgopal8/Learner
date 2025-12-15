class HomeController < ApplicationController
  def index
    # Home page - displays the main landing page
    # Cache popular data for better performance
    @featured_courses = Rails.cache.fetch('featured_courses', expires_in: 1.hour) do
      Course.limit(6).order('RANDOM()')
    end
    
    @stats = Rails.cache.fetch('course_stats', expires_in: 24.hours) do
      {
        total_students: User.count,
        total_courses: Course.count,
        total_instructors: User.count, # Simplified for now
        success_rate: 95
      }
    end
  end

  def about
    # About page - displays information about LearnHub
  end

  def login
    # Login page - displays the login form
    self.resource = User.new
    self.resource_name = :user
  end

  def signup
    # Signup page - displays the registration form
    self.resource = User.new
    self.resource_name = :user
  end

  private

  attr_writer :resource, :resource_name
end
