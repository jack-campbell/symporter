require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
    @u = us(:michael)
  end

  test "password resets" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    # Invalid email
    post password_resets_path, password_reset: { email: "" }
    assert_not flash.empty?
    assert_template 'password_resets/new'
    # Valid email
    post password_resets_path, password_reset: { email: @u.email }
    assert_not_equal @u.reset_digest, @u.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
    # Password reset form
    u = assigns(:u)
    # Wrong email
    get edit_password_reset_path(u.reset_token, email: "")
    assert_redirected_to root_url
    # Inactive u
    u.toggle!(:activated)
    get edit_password_reset_path(u.reset_token, email: u.email)
    assert_redirected_to root_url
    u.toggle!(:activated)
    # Right email, wrong token
    get edit_password_reset_path('wrong token', email: u.email)
    assert_redirected_to root_url
    # Right email, right token
    get edit_password_reset_path(u.reset_token, email: u.email)
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", u.email
    # Invalid password & confirmation
    patch password_reset_path(u.reset_token),
          email: u.email,
          u: { password:              "foobaz",
                  password_confirmation: "barquux" }
    assert_select 'div#error_explanation'
    # Empty password
    patch password_reset_path(u.reset_token),
          email: u.email,
          u: { password:              "",
                  password_confirmation: "" }
    assert_not flash.empty?
    assert_template 'password_resets/edit'
    # Valid password & confirmation
    patch password_reset_path(u.reset_token),
          email: u.email,
          u: { password:              "foobaz",
                  password_confirmation: "foobaz" }
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to u
  end
end
