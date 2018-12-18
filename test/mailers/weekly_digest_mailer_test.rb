require 'test_helper'

class WeeklyDigestMailerTest < ActionMailer::TestCase
  test "weekly_promos" do
    mail = WeeklyDigestMailer.weekly_promos
    assert_equal "Weekly promos", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
