class Task < ActiveRecord::Base
  belongs_to :requester, :class_name=>"User"
  belongs_to :assignee, :class_name=>"User"

  scope :grouped, group(:assignee_id)


  def self.all_active
    find(:all, :order =>"assignee_id, priority", :conditions => ["complete = ?",false])
  end
  # #def self.all_active_by_requester
  #   # Need to filter User.department = 3371
  #   self.where("complete = ?",false).order("requester_id, assignee_id, category, priority")
  # end
  def self.all_my_active(user_id)
    find(:all, :order =>"assignee_id, priority", :conditions => ["complete = ? AND assignee_id = ?",false, user_id])
  end

  def self.all_active_past_due
    date=Date.today
    find(:all, :order =>"assignee_id, priority, scd", :conditions => ["scd < ? and complete = ?", date, false])
  end
  def self.all_my_active_past_due(user_id)
    date=Date.today
    find(:all, :order =>"assignee_id, priority, scd", :conditions => ["scd < ? and complete = ? and assignee_id = ?", date, false,user_id])
  end
  def self.all_completed
    date=Date.today
    find(:all, :order =>"assignee_id, scd", :conditions => ["complete = ?",  true])
  end
  def self.all_unassigned
    date=Date.today
    find(:all, :order =>"id" , :conditions => "assignee_id IS NULL")
  end
  def self.all_active_assigned_to(u)
    find(:all, :order =>"assignee_id, priority", :conditions => ["requester_id = ? AND complete = ?",u,false])
  end
  def self.all_my_active_by_me(user_id)
    self.where("complete = ? AND requester_id = ?",false, user_id).order("assignee_id, priority")
  end
  def self.all_active2
    t = self.where("tasks.complete = 'f' AND tasks.assignee_id IS NOT NULL AND category < '5'").order("users.fullname, tasks.category, tasks.priority").joins('INNER JOIN users ON users.id = tasks.assignee_id').select('users.fullname, tasks.*')
    t.group_by(&:fullname)
  end
 
  def self.all_active_by_requester
    t = self.where("tasks.complete = 'f' AND tasks.requester_id IS NOT NULL").order("users.fullname, tasks.category, tasks.priority").joins('INNER JOIN users ON users.id = tasks.requester_id').select('users.fullname, tasks.*')
    t.group_by(&:fullname)
  end

  def self.all_active_manual_sort(id)
    t = self.where("tasks.complete = 'f' AND tasks.assignee_id = ?", id).order("users.fullname, tasks.category, tasks.priority").joins('INNER JOIN users ON users.id = tasks.assignee_id').select('users.fullname, tasks.*')
  end
  
  def self.all_active3
    t = self.where("complete = 'f' AND assignee_id IS NOT NULL AND priority < 99 ").order("assignee_id, category, priority, scd")
    t.group_by(&:assignee_id)
  end
  def self.all_active_no_priority
    t = self.where("priority IS NULL")
    t.group_by(&:assignee_id)
  end
  #
  # new section for 10-04-2011
  #**
  #rework and refactor all queries
  def self.get_tasks(params)
    #param definitions
    #a_id: single id filter
    #complete: complete filter
    #category: category filter
    #sort_order: sort_by assignee, requester, ...
    results = scoped
    results = results.where("assignee_id like ?", "%" + params[:a_id] + "%") if params[:a_id]
    results = results.where("complete like ?", "%" + params[:complete] + "%") if params[:complete]
    results = results.where("category like ?", "%" + params[:category] + "%") if params[:category]
    results = results.order("assignee_id, category, priority") if params[:sort_order]=='assignee'
    results = results.order("requester_id, category, priority") if params[:sort_order]=='requester'
    results
  end

end
