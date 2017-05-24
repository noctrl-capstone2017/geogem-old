class GraphController < ApplicationController
  def main
    
  end

  def example
    @allSessions = Session.all
    @studentSessions = Session.where(session_student:1)
    @last2sessions = @studentSessions.last(2)
    @sesh1Events = SessionEvent.where(@studentSessions.first(1))
    @otherStudentSesh = Session.where(session_student:1).first(1)
  end

  def random
  end

  def todo
  end

  def other
  end
end
