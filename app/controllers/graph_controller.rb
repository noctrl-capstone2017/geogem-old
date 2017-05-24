class GraphController < ApplicationController
  def main
    
  end

  def example
    @allSessions = Session.all
    @studentSessions = Session.where(session_student:1)
    @last3sessions = @studentSessions.last(3)
  end

  def random
  end

  def todo
  end

  def other
  end
end
