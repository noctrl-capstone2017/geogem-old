require 'test_helper'
#load "#{Rails.root}/db/seeds.rb"

class ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get data from session" do
    get assigns(:session)
    assert_response :success
  end
  

  test "should render pdf page" do
    get '/report1'
    assert_response :success
  end
  
  # Include test for logged in user? Is this functional in the application_controller?
  # Additional tests on the way after controller refactoring
end