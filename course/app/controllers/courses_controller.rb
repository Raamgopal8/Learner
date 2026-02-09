class CoursesController < ApplicationController
  before_action :authenticate_user!, only: [:enroll]
  def index
    # Base query with all filters
    @courses = Course.all

    # Apply filters if provided
    @courses = @courses.by_category(params[:category]) if params[:category].present?
    @courses = @courses.by_level(params[:level]) if params[:level].present?
    @courses = @courses.by_level(params[:level]) if params[:level].present?
    
    # Apply sorting
    
    # Apply sorting
    case params[:sort]
    when 'price_low'
      @courses = @courses.order(price: :asc)
    when 'price_high'
      @courses = @courses.order(price: :desc)
    when 'newest'
      @courses = @courses.recent
    when 'featured'
      @courses = @courses.featured
    else
      @courses = @courses.order(created_at: :desc) # Default: newest first
    end

    # Filter options for the view
    @categories = Course.categories
    @levels = Course.levels
    @featured_courses = Course.featured.limit(6)
    @recent_courses = Course.recent.limit(6)

    # Search functionality
    if params[:search].present?
      @courses = @courses.where('title ILIKE ? OR description ILIKE ?',
                               "%#{params[:search]}%", "%#{params[:search]}%")
    end

    # Pagination
    @courses = @courses.page(params[:page]).per(12)
  end

  def show
    @course = Course.find(params[:id])
    @enrolled = current_user&.enrollments&.where(course: @course)&.exists?
    @related_courses = Course.where(category: @course.category)
                           .where.not(id: @course.id)
                           .limit(4)
  end

  def enroll
    @course = Course.find(params[:id])
    
    if current_user
      if current_user.enrollments.where(course: @course).exists?
        redirect_to @course, notice: 'You are already enrolled in this course.'
      else
        @enrollment = current_user.enrollments.build(course: @course, enrollment_data: Time.current)
        if @enrollment.save
          # Send enrollment email
          CourseMailer.enrollment_email(current_user, @course).deliver_later
          redirect_to @course, notice: 'You have successfully enrolled in the course!'
        else
          redirect_to @course, alert: 'Unable to enroll. Please try again.'
        end
      end
    else
      redirect_to login_path, alert: 'You must be logged in to enroll.'
    end
  end

  def unenroll
    @course = Course.find(params[:id])
    if current_user
      @enrollment = current_user.enrollments.find_by(course: @course)
      if @enrollment&.destroy
        redirect_to @course, notice: 'You have successfully unenrolled from the course.'
      else
        redirect_to @course, alert: 'Unable to unenroll. Please try again.'
      end
    else
      redirect_to login_path, alert: 'You must be logged in to unenroll.'
    end
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to @course, notice: 'Course was successfully created.'
    else
      render :new
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    if @course.update(course_params)
      redirect_to @course, notice: 'Course was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to courses_url, notice: 'Course was successfully destroyed.'
  end

  private

  def course_params
    params.require(:course).permit(:title, :description, :instructor, :duration,
                                 :price, :level, :category, :featured, :image_url,
                                 :content, :syllabus, learning_outcomes: [])
  end
end
