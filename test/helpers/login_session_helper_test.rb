# Login Session Helper Test
# Test the desired “remember” branch
# Author: Meagan Moore & Steven Royster

require 'test_helper'

# THIS IS ALL COMMENTED OUT BECAUSE IT SHOULD BE USED FOR
#   THE 'REMEMBER ME' FEATURE WHICH WE ARE NOT IMPLEMENTING
class LoginSessionHelperTest < ActionView::TestCase

  def setup
    @teacher = teachers(:one)
  end

  test "current_teacher returns right teacher when session is nil" do
    assert_equal @teacher, current_teacher
    assert is_logged_in?
  end

end