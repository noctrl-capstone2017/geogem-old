require 'test_helper'
require "net/http"
#Kevin Portland

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
  
  #pings google's graph API and returns true if response is a success (2XX range)
  test "google should respond" do # adapted from https://stackoverflow.com/questions/5908017/check-if-url-exists-in-ruby
    url = URI.parse("https://www.gstatic.com/charts/loader.js")
    req = Net::HTTP.new(url.host, url.port)
    req.use_ssl = (url.scheme == 'https')
    path = url.path if url.path.present?
    res = req.request_head(path || '/')
    assert res.kind_of?(Net::HTTPSuccess) #replace HTTPRedirection w/ HTTPSuccess to test for correct response.
  end
end
