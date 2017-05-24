# Teachers Login Test
# Teacher login information tests
# Author: Meagan Moore & Steven Royster

require 'test_helper'
require 'login_session_helper'

class TeachersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @teacher = teachers(:one)
  end
  
  # Test logging in as a user with invalid credentials
  # Assure that the flash worked
  test "login with invalid information" do
    get login_path
    assert_template 'login_session/new'
    post login_path, params: { login_session: { user_name: "", password: "" } }
    assert_template 'login_session/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  # test for user logout
  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: { login_session: { user_name: @teacher.user_name, password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @teacher
    follow_redirect!
    assert_template 'teachers/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", teacher_path(@teacher)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # Simulate a user clicking logout in a second window.
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", teacher_path(@teacher), count: 0
  end

  # test "login with remembering" do
  #   log_in_as(@teacher, remember_me: '1')
  #   assert_not_nil cookies['remember_token']
  # end

  # test "login without remembering" do
  #   # Log in to set the cookie.
  #   log_in_as(@teacher, remember_me: '1')
  #   # Log in again and verify that the cookie is deleted.
  #   log_in_as(@teacher, remember_me: '0')
  #   assert_empty cookies['remember_token']
  # end
  
  # Steven Royster
  test "should flash incorrect username/password combination" do
    get login_path
    assert_template 'login_session/new'
    post login_path, params: { login_session: { user_name: "", password: "" } }
    assert_template 'login_session/new'
    assert_not flash.empty?
  end
end