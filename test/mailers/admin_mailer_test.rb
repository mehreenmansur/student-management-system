require 'test_helper'

class AdminMailerTest < ActionMailer::TestCase
  test "mailResults" do
    mail = AdminMailer.mailResults
    assert_equal "Mailresults", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
