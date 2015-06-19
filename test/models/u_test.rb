require 'test_helper'

class UTest < ActiveSupport::TestCase
def setup
  @u = U.new(name: "Example U", email: "user@example.com",
                  password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @u.valid?
  end
    test "name should be present" do
    @u.name = "     "
    assert_not @u.valid?
  end
  test "email should be present" do
    @u.email = "     "
    assert_not @u.valid?
end
  
  test "name should not be too long" do
    @u.name = "a" * 51
    assert_not @u.valid?
  end

  test "email should not be too long" do
    @u.email = "a" * 244 + "@example.com"
    assert_not @u.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @u.email = valid_address
      assert @u.valid?, "#{valid_address.inspect} should be valid"
    end
    
     test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @u.email = invalid_address
      assert_not @u.valid?, "#{invalid_address.inspect} should be invalid"
    end
    
      test "email addresses should be unique" do
    duplicate_u = @u.dup
    duplicate_u.email = @u.email.upcase
    @u.save
    assert_not duplicate_u.valid?
  end
    
     test "password should have a minimum length" do
    @u.password = @u.password_confirmation = "a" * 5
    assert_not @u.valid?
  end
    test "authenticated? should return false for a user with nil digest" do
    assert_not @u.authenticated?('')
  end
end
end