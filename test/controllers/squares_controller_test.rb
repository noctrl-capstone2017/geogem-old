require 'test_helper'

class SquaresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @square = squares(:one)
  end

  test "should get index" do
    get squares_url
    assert_response :success
  end

  test "should get new" do
    get new_square_url
    assert_response :success
  end

  test "should create square" do
    assert_difference('Square.count') do
      post squares_url, params: { square: { color: @square.color, description: @square.description, full_name: @square.full_name, school_id: @square.school_id, screen_name: @square.screen_name, type: @square.type } }
    end

    assert_redirected_to square_url(Square.last)
  end

  test "should show square" do
    get square_url(@square)
    assert_response :success
  end

  test "should get edit" do
    get edit_square_url(@square)
    assert_response :success
  end

  test "should update square" do
    patch square_url(@square), params: { square: { color: @square.color, description: @square.description, full_name: @square.full_name, school_id: @square.school_id, screen_name: @square.screen_name, type: @square.type } }
    assert_redirected_to square_url(@square)
  end

  test "should destroy square" do
    assert_difference('Square.count', -1) do
      delete square_url(@square)
    end

    assert_redirected_to squares_url
  end
end
