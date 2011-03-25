require 'test_helper'

class ContactTest < ActionMailer::TestCase
  test "contact" do
    mail = Contact.contact("foo@example.com", "Foo Bar", "Test Subject", "Problem", "P")
    assert_equal "Problem: Test Subject", mail.subject
    assert_equal ["photocaching@ars-subtilior.com"], mail.to
    assert_equal ["info@mail.iphotocache.com"], mail.from
    assert_match "Subject: Test Subject\r\nType: Problem\r\nSender: foo@example.com\r\nName: Foo Bar\r\n\r\nBody: P", mail.body.encoded
  end

end
