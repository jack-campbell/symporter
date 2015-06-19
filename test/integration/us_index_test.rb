require 'test_helper'

class UsIndexTest < ActionDispatch::IntegrationTest

  def setup
    @u = us(:michael)
  end

  test "index including pagination" do
    log_in_as(@u)
    get us_path
    assert_template 'us/index'
    assert_select 'div.pagination'
    U.paginate(page: 1).each do |u|
      assert_select 'a[href=?]', u_path(u), text: u.name
    end
  end
end