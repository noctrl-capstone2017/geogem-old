#DJ Removed test by kevin Portland because of improper method calls
#Instead added test to see if a session has a student assigned
require 'test_helper'

class SessionTest < ActiveSupport::TestCase
  def setup
    @session = sessions(:one)
  end
  test "session belongs to student" do
    testSess = @session.session_student
    assert_not_nil(testSess)
  end
end
