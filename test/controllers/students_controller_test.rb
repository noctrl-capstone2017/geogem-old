require 'test_helper'

class StudentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student = students(:one)
  end

  test "should get index" do
    get students_url
    assert_response :success
  end

  test "should get new" do
    get new_student_url
    assert_response :success
  end

test "should create student" do
        assert_difference('Student.count') do
          post students_url, params: { student: { color: "red", school_id: "1", 
          contact_info: "hey", 
          description: "Hey", 
          icon: "bug", screen_name: "hey", 
          full_name: "James S"} }
    end
    assert_redirected_to students_url
  end

  test "should not create student. Empty name." do
    assert_no_difference('Student.count') do
      post students_url, params: { student: { color: "red", school_id: "1", 
      contact_info: "hey", 
      description: "Hey", 
      icon: "bug", screen_name: "hey", 
      full_name: ""} }
    end
  end
  
  test "should not create student" do
    assert_no_difference('Student.count') do
      duplicate_item = @student.dup
      assert_not duplicate_item.valid?
    end
  end
  
  test "should show student" do
    get student_url(@student)
    assert_response :success
  end

  test "should get edit" do
    get edit_student_url(@student)
    assert_response :success
  end

  test "should update student" do
    patch student_url(@student), params: { student: { color: "red", school_id: "1", 
      contact_info: "hey", 
      description: "Hey", 
      icon: "bug", screen_name: "hey", 
      full_name: "James L"} }
      assert_redirected_to students_url
  end
  
  test "should not update student. Empty name." do
    patch student_url(@student), params: { student: { color: "red", school_id: "1", 
      contact_info: "hey", 
      description: "Hey", 
      icon: "bug", screen_name: "hey", 
      full_name: ""} }
  end

  test "should destroy student" do
    assert_difference('Student.count', -1) do
      delete student_url(@student)
    end

    assert_redirected_to students_url
  end
end
