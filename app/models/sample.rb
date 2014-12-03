class Sample < ActiveRecord::Base
  has_one :manid
  
  def self.linked_tables
    t=self.order(manids.device).joins('INNER JOIN manids ON manids.id = samples.manid_id')
    
    
    #t = self.where("tasks.complete = 'f' AND tasks.assignee_id IS NOT NULL AND category < '5'").order("users.fullname, tasks.priority").joins('INNER JOIN users ON users.id = tasks.assignee_id').select('users.fullname, tasks.*').includes("requester").includes("assignee")
    
    
  end
end
