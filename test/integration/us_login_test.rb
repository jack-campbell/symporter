require 'test_helper'

class UsLoginTest < ActionDispatch::IntegrationTest
    def setup
    @u = us(:michael)
  end
  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: "", password: "" }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty

    test "login with valid information followed by logout" do
    get login_path
    post login_path, session: { email: @u.email, password: 'password' }
    assert is_logged_in?
    assert_redirected_to @u
    follow_redirect!
    assert_template 'us/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", u_path(@u)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", u_path(@u), count: 0
  end
    test "login with remembering" do
    log_in_as(@u, remember_me: '1')
    assert_not_nil cookies['remember_token']
  end

  test "login without remembering" do
    log_in_as(@u, remember_me: '0')
    assert_nil cookies['remember_token']
  end
end
