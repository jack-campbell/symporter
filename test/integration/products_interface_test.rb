require 'test_helper'

class ProductsInterfaceTest < ActionDispatch::IntegrationTest
  test "product interface" do
    log_in_as(@u)
    get root_path
    assert_select 'div.pagination'
    # Invalid submission
   assert_no_difference 'Product.count' do
     post products_path, product: { content: "" }
    end
    assert_select 'div#error_explanation'
    # Valid submission
    description = "This product really ties the room together"
   assert_difference 'Product.count', 1 do
     post products_path, product: { content: content }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # Delete a post.
    assert_select 'a', text: 'delete'
   first_product = @u.products.paginate(page: 1).first
    assert_difference 'product.count', -1 do
      delete products_path(first_products)
    end
    # Visit a different user.
    get u_path(us(:archer))
    assert_select 'a', text: 'delete', count: 0
  end
end
