class EnrollmentNotificationMailer < ApplicationMailer
  def enrollment_notification(user, course)
    @user = user
    @course = course
    @greeting = "Hi"

    mail to: user.email, subject: "Welcome to #{course.title}!"
  end
end
