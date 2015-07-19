require 'test_helper'

class UMailerTest < ActionMailer::TestCase
  test "account_activation" do
   
    u = us(:michael)
    u.activation_token = U.new_token
    mail = UMailer.account_activation(u)
    assert_equal "Account activation", mail.subject
    assert_equal [u.email], mail.to
    assert_equal ["noreply@symporter.co"], mail.from
    assert_match u.name,               mail.body.encoded
    assert_match u.activation_token,   mail.body.encoded
    assert_match CGI::escape(u.email), mail.body.encoded
  end


  test "password_reset" do

    u = u(:michael)
    u.reset_token = U.new_token
    mail = UMailer.password_reset(u)
    assert_equal "Password reset", mail.subject
    assert_equal [u.email], mail.to
    assert_equal ["noreply@symporter.co"], mail.from
    assert_match u.reset_token,        mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded

  end

end
