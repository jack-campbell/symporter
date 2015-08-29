require 'test_helper'

class UsEditTest < ActionDispatch::IntegrationTest

  def setup
    @u = us(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@u)
    get edit_u_path(@u)
    assert_template 'us/edit'
    patch u_path(@u), u: { name:  "",
                                    email: "foo@invalid",
                                    city: "goo",
                                    institution: "gar",
                                    password:              "foo",
                                    password_confirmation: "bar", city: "London", institution: "ICL"  }
    assert_template 'us/edit'
  end
  
  test "successful edit" do
    log_in_as(@u)
    get edit_u_path(@u)
    assert_template 'us/edit'
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch u_path(@u), u: { name:  name,
                                    email: email,
                                     city: city,
                                    institution: institution,
                                    password:              "",
                                    password_confirmation: "" }
    assert_not flash.empty?
    assert_redirected_to @u
    @u.reload
    assert_equal name,  @u.name
    assert_equal email, @u.email
  end
  
   test "successful edit with friendly forwarding" do
    get edit_u_path(@u)
    log_in_as(@u)
    assert_redirected_to edit_u_path(@u)
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch u_path(@u), u: { name:  name,
                                    email: email,
                                     city: city,
                                    institution: institution,
                                    password:              "",
                                    password_confirmation: "" }
    assert_not flash.empty?
    assert_redirected_to @u
    @u.reload
    assert_equal name,  @u.name
    assert_equal email, @u.email
  end
  
end
