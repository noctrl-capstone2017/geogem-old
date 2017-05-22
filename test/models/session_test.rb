#kevin Portland
require 'test_helper'

class SessionTest < ActiveSupport::TestCase
  def setup
    @timmy = Student.new(id: 1)
  end
  test "session belongs to student" do
    testSess = @timmy.sessions.build(tally: 1, start: 1.day.ago)
    assert_same(testSess.student_id,1)
  end
end
