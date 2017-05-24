#Kevin Portland
require 'test_helper'

class SessionTest < ActiveSupport::TestCase
  def setup
    @timmy = Student.new(id: 1)
    @testSess = Session.new(id:1)
  end
  test "session belongs to student" do 
    timmySess = Session.new(session_student:1) #structure not idiomatic =(
    assert_same(timmySess.session_student,@timmy.id)
  end
  test "session_event belongs to session" do
    testEvent = SessionEvent.new(session_id:1)
    assert_same(testEvent.session_id,@testSess.id)
  end
end
