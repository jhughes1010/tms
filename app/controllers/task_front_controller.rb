class TaskFrontController < ApplicationController
  def top3Serial
    @tasks = Task.topActiveSerial(3)
  end

  def top3All
    @tasks = Task.topActive(3)
  end

end
