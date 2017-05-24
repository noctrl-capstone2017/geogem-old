require 'test_helper'

class RosterSquaresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @roster_square = roster_squares(:one)
  end

  test "should get new" do
    get new_roster_square_url
    assert_response :success
  end

  test "should create roster_square" do
    assert_difference('RosterSquare.count') do
      post roster_squares_url, params: { roster_square: { square_id: "1", student_id: "1" } }
    end

    assert_redirected_to roster_square_url(RosterSquare.last)
  end

  test "should get edit student 1" do
    get edit_roster_square_url(1)
    assert_response :success
  end

  test "should destroy roster_square" do
    assert_difference('RosterSquare.count', -1) do
      delete roster_square_url(1)
    end

    assert_redirected_to roster_squares_url
  end
end
