class TaskFrontController < ApplicationController
  def top3Serial
  end

  def top3All
    @tasks = Task.topActive(3)
    @tasksCategoryCount = Array.new
    @tasksCategoryCount[1] = Task.categoryCount(1)
    @tasksCategoryCount[2] = Task.categoryCount(2)
    @tasksCategoryCount[3] = Task.categoryCount(3)
    @tasksCategoryCount[4] = Task.categoryCount(4)
  end

end
