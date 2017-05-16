# Author: Nate V
# Reports Testing File
# WIP, awaiting refactoring to provide full test functionality

require 'test_helper'
# This line should give the test access to the database seed. Not currently functional
#load "#{Rails.root}/db/seeds.rb"

class ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get data from session" do
    get assigns(session)
    assert_response :success
  end
  

  test "should get pdf page" do
    get '/report1'
    assert_response :success
  end
  
  # Include test for logged in user? Is this functional in the application_controller?
  
  # Additional tests on the way after controller refactoring
  # WIP
  #test "should get refactor page #1" do
  #  get :refactor1
  #  assert_response :success
  #end
  
  #test "should get refactor page #2" do
  #  get :refactor2
  #  assert_response :success
  #end
  
  #test "should get refactor page #3" do
  #  get :refactor2
  #  assert_response :success
  #end
end