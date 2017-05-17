#Robert Herrera
require 'test_helper'

class SchoolsControllerTest < ActionDispatch::IntegrationTest
    

  test "should get super dashboard" do
    get super_url
    assert_response :success
  end

end