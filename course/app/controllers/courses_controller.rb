class CoursesController < ApplicationController
  def index
    # Base query with all filters
    @courses = Course.all

    # Apply filters if provided
    @courses = @courses.by_category(params[:category]) if params[:category].present?
    @courses = @courses.by_level(params[:level]) if params[:level].present?
    @enrolled = current_user.enrollments.where(course: @course).exists? if current_user
    
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
    @related_courses = Course.where(category: @course.category)
                           .where.not(id: @course.id)
                           .limit(4)
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
                                 :price, :level, :category, :featured, :image_url)
  end
end
