# author: Kevin M, Tommy B

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

  test "should show teacher" do
    get teacher_url(@teacher)
    assert_response :success
  end

  test "should get edit" do
    get edit_teacher_url(@teacher)
    assert_response :success
  end

  test "should destroy teacher" do
    assert_difference('Teacher.count', -1) do
      delete teacher_url(@teacher)
    end

    assert_redirected_to teachers_url
  end
  
  test "should properly load existing info when loading a profile" do
    get edit_teacher_url(@teacher)
    assert_template "teachers/edit"
    #This is all that's necessary, since if one part of it fails, all of it does.
    assert_select 'h2', text: 'Teacher profile for ' + @teacher.full_name
  end
  
  # Steven Royster
  # Inspired by previous capstone class
  test "should show superadmin" do
    log_in_as(teachers(:one))
    get :show, id: @teacher
    assert_response :success
  end
end
