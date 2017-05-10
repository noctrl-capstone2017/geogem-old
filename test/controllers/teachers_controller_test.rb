require 'test_helper'

class TeachersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @teacher = teachers(:one)
  end

  test "should get index" do
    get teachers_url
    assert_response :success
  end

  test "should get new" do
    get new_teacher_url
    assert_response :success
  end

  test "should create teacher" do
    assert_difference('Teacher.count') do
      post teachers_url, params: { teacher: { color: @teacher.color, description: @teacher.description, email: @teacher.email, full_name: @teacher.full_name, icon: @teacher.icon, last_login: @teacher.last_login, password_digest: @teacher.password_digest, powers: @teacher.powers, school_id: @teacher.school_id, screen_name: @teacher.screen_name, user_name: @teacher.user_name } }
    end

    assert_redirected_to teacher_url(Teacher.last)
  end

  test "should show teacher" do
    get teacher_url(@teacher)
    assert_response :success
  end

  test "should get edit" do
    get edit_teacher_url(@teacher)
    assert_response :success
  end

  test "should update teacher" do
    patch teacher_url(@teacher), params: { teacher: { color: @teacher.color, description: @teacher.description, email: @teacher.email, full_name: @teacher.full_name, icon: @teacher.icon, last_login: @teacher.last_login, password_digest: @teacher.password_digest, powers: @teacher.powers, school_id: @teacher.school_id, screen_name: @teacher.screen_name, user_name: @teacher.user_name } }
    assert_redirected_to teacher_url(@teacher)
  end

  test "should destroy teacher" do
    assert_difference('Teacher.count', -1) do
      delete teacher_url(@teacher)
    end

    assert_redirected_to teachers_url
  end
end
