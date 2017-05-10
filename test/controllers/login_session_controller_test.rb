require 'test_helper'

class LoginSessionControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get login_session_new_url
    assert_response :success
  end

end
