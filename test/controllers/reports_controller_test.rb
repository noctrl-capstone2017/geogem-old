# Author: Nate V, Taylor S
# Reports Testing File

require 'test_helper'
require 'login_session_helper'
# This line should give the test access to the database seed. Not currently functional
#load "#{Rails.root}/db/seeds.rb"

class ReportsControllerTest < ActionDispatch::IntegrationTest
  
  #Taylor S
  #Setup the teacher, student, and session for the report
  def setup
    @teacher = teachers(:one)
    @student = students(:one)
    @session = sessions(:one)
    @session_event = session_events(:one)
  end
  
  
  #TS
  #Checks to see if a logged out user gets redirected when
  #trying to access /report1
  test "must be logged in" do
    post report1_url, params: {id: @session.id}
    assert_response :redirect #should get redirected because not logged in
  end
  
    #TS
  #Checks to see if a logged in teacher can get the report
  test "should_get_report" do
    log_in_as(@teacher)
    #send in the id for the session of interest
    post report1_url, params: {id: @session.id}
    assert_response :success
  end
  
  
  #TS
  #I couldn't think of many test ideas, so I tested the fixutres to
  #make sure they were working properly
  
  test "teacher1_should_not_be_nil" do
  assert_not_nil(@teacher.full_name, "Teacher1 fixture is nil")
  end
  
  #TS
  test "student1_should_not_be_nil" do
  assert_not_nil(@student.full_name, "Student1 fixture is nil") 
  end
  
  #TS
  test "session1_should_not_be_nil" do
  assert_not_nil(@session.start_time, "Session1 fixture is nil") 
  end
  
  #Checks to see if a logged in teacher can get the csv file
  test "should_get_csv" do
    log_in_as(@teacher)
    #send in the id for the session of interest
    post csv_url, params: {id: @session.id}
    assert_response :success
  end
  
end