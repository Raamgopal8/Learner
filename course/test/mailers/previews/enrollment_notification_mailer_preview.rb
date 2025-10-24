# Preview all emails at http://localhost:3000/rails/mailers/enrollment_notification_mailer
class EnrollmentNotificationMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/enrollment_notification_mailer/enrollment_notification
  def enrollment_notification
    EnrollmentNotificationMailer.enrollment_notification
  end
end
