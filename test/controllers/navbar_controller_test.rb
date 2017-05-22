# Author: Carolyn C
require 'test_helper'

class NavbarControllerTest < ActionDispatch::IntegrationTest

test "should get navbar1 for help" do
    get help_path
    assert_response :success
end

test "should get navbar2" do
    get login_path
    assert_response :success
end
  
test "should get navbar3 for about1" do
    get about1_path
    assert_response :success
end

test "should get navbar3 for about2" do
    get about2_path
    assert_response:success
end

test "should get navbar3 for logout" do
    get logout_path
    assert_response:success
end

end