require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  test "should get about student art" do
    get about2_url
    assert_response :success
    assert_select "h2", "About student art - artwork contributed to Dinner Out"
    #uncomment when pushed
    #assert_select "a[href=mailto:?]",'wtkrieger@noctrl.edu', count: 1
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
    assert_select "h2", "Help  - frequently asked questions about Dinner Out"
  end
end