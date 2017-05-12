require 'test_helper'

class SessionNoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @teacher = teachers(:one)
    @student = students(:two)
    @session = sessions(:one)
    @session_note = SessionNote.new(note: "Lorem ipsum", session_id: @session.id)
  end
  
  test "should be valid" do
    assert @session_note.valid?
  end
  
  test "session id should be present" do
    @session_note.session_id = nil
    assert_not @session_note.valid?
  end
end