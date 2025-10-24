require "test_helper"

class EnrollmentNotificationMailerTest < ActionMailer::TestCase
  test "enrollment_notification" do
    mail = EnrollmentNotificationMailer.enrollment_notification
    assert_equal "Enrollment notification", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
