require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  
  def setup
     @u = us(:michael)
    @product = @u.microposts.build(name: "Lorem ipsum", description: "Lorem ipsum")
  end
  
  test "name should be present" do
    @product.name = "     "
    assert_not @product.valid?
  end
  
  test "name should not be too long" do
    @product.name = "a" * 51
    assert_not @product.valid?
  end
  
  test "description should be at most 140 characters" do
    @product.description = "a" * 10001
    assert_not @product.valid?
  end

  test "should be valid" do
    assert @product.valid?
  end

  test "description should be present" do
    @product.description = "   "
    assert_not @product.valid?
  end
  
  test "user id should be present" do
    @product.user_id = nil
    assert_not @product.valid?
  end
  
   test "order should be most recent first" do
     assert_equal products(:most_recent), Product.first
  end
end
