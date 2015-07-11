require 'test_helper'

class ProductControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end
def setup
  @product = products(:orange)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Product.count' do
      post :create, product: { content: "Lorem ipsum" }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Micropost.count' do
      delete :destroy, id: @product
    end
    assert_redirected_to login_url
  end
end