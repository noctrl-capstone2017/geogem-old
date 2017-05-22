# Author: Robert Herrera
require 'test_helper'

class SchoolsControllerTest < ActionDispatch::IntegrationTest
   # Use the fixtures to set the testing env's school. Teacher is set to super user.
  setup do
    @school = schools(:one)
    log_in_as(teachers(:one))
  end
  
  #This test makes sure super_url gets the super dashboard page
  test "should get super dashboard" do
    get super_url
    assert_response :success
  end

  test "should get schools index" do
    get schools_url
    assert_response :success
  end
end