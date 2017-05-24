class GraphController < ApplicationController
  def main
    
  end

  def example
    @sessionGroup = Student.find_by(id:1).sessions
  end

  def random
  end

  def todo
  end

  def other
  end
end
