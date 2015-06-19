require 'test_helper'
def setup
    @u = us(:michael)
   @other_u = us(:archer)
  end
class UsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end
test "should redirect edit when not logged in" do
    get :edit, id: @u
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @u, u: { name: @u.name, email: @u.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_u)
    get :edit, id: @u
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_u)
    patch :update, id: @u, u: { name: @u.name, email: @u.email }
    assert flash.empty?
    assert_redirected_to root_url
  end
 test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end
  test "should redirect destroy when not logged in" do
    assert_no_difference 'U.count' do
      delete :destroy, id: @u
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_u)
    assert_no_difference 'U.count' do
      delete :destroy, id: @u
    end
    assert_redirected_to root_url
  end
end
