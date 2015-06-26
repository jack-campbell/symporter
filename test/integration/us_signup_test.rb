require 'test_helper'

class UsSignupTest < ActionDispatch::IntegrationTest
  
   def setup
    ActionMailer::Base.deliveries.clear
  end
  
 test "invalid signup information" do
    get signup_path
    assert_no_difference 'U.count' do
      post us_path, u: { name:  "",
                               email: "user@invalid",
                               password:              "foo",
                               password_confirmation: "bar" }
    end 
    assert_template 'us/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
    end 
      test "valid signup information with account activation" do
    get signup_path
    assert_difference 'U.count', 1 do
      post us_path, u: { name:  "Example User",
                               email: "user@example.com",
                               password:              "password",
                               password_confirmation: "password" }
    end
     
  assert_equal 1, ActionMailer::Base.deliveries.size
    u = assigns(:u)
    assert_not u.activated?
    # Try to log in before activation.
    log_in_as(u)
    assert_not is_logged_in?
    # Invalid activation token
    get edit_account_activation_path("invalid token")
    assert_not is_logged_in?
    # Valid token, wrong email
    get edit_account_activation_path(u.activation_token, email: 'wrong')
    assert_not is_logged_in?
    # Valid activation token
    get edit_account_activation_path(u.activation_token, email: u.email)
    assert u.reload.activated?
    follow_redirect!
    assert_template 'us/show'
    assert is_logged_in?
  end
  end
end
