require 'test_helper'

class UsSignupTest < ActionDispatch::IntegrationTest
 test "invalid signup information" do
    get signup_path
    assert_no_difference 'U.count' do
      post us_path, u: { name:  "",
                               email: "user@invalid",
                               password:              "foo",
                               password_confirmation: "bar" }
      test "valid signup information" do
    get signup_path
    assert_difference 'U.count', 1 do
        post_via_redirect us_path, u: { name:  "Example User",
                                            email: "user@example.com",
                                            password:              "password",
                                            password_confirmation: "password" }
    end
    assert_template 'us/new'
      assert_template 'us/show'
       assert is_logged_in?
  end
end
