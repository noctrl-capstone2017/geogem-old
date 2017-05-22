require 'test_helper'

class GraphControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get graph_main_url
    assert_response :success
  end

  test "should get example" do
    get graph_example_url
    assert_response :success
  end

  test "should get random" do
    get graph_random_url
    assert_response :success
  end

  test "should get todo" do
    get graph_todo_url
    assert_response :success
  end

  test "should get other" do
    get graph_other_url
    assert_response :success
  end

end
