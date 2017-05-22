class GraphController < ApplicationController
  def main
    @sessionGroup = Student.find_by(id:1).sessions
  end

  def example
  end

  def random
  end

  def todo
  end

  def other
  end
end
