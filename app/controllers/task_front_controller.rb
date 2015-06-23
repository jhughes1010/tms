class TaskFrontController < ApplicationController
  def top3Serial
    @tasks = Task.topActiveSerial(3)
  end

  def top3All
    @tasks = Task.topActive(3)
  end
  
  def taskonetwo
    tasks = Task.all_active
    tasks.each do |task|
      if task.category == 1
        task.category = 2
        task.save
      end
    end
    def remap_unassigned
      @unassigned_user_id = User.unassigned_id
    end

 
    
  end

end
