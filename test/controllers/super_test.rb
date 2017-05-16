#Robert Herrera
require 'test_helper'

class SchoolsControllerTest < ActionDispatch::IntegrationTest
    
  setup do
    @teacher = teachers(:one)
  end

  
  test "should get super dashboard" do
    get super_url
    assert_response :success
  end
end
  
  
  
  
  
  
  
  
end