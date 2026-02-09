class CourseMailer < ApplicationMailer
  default from: 'notifications@tutorx.com'

  def enrollment_email(user, course)
    @user = user
    @course = course
    mail(to: @user.email, subject: "Course Enrollment Confirmation: #{@course.title}")
  end
end
