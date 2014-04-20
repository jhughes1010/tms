class Task < ActiveRecord::Base
  belongs_to :requester, :class_name=>"User"
  belongs_to :assignee, :class_name=>"User"

  # scope :grouped, group(:assignee_id)


  def self.all_active
    find(:all, :order =>"assignee_id, priority", :conditions => ["complete = ?",false])
  end
  def self.all_unassigned
    date=Date.today
    find(:all, :order =>"id" , :conditions => "assignee_id IS NULL")
  end
  def self.all_active2
    t = self.where("tasks.complete = 'f' AND tasks.assignee_id IS NOT NULL AND category < '5'").order("users.fullname, tasks.priority").joins('INNER JOIN users ON users.id = tasks.assignee_id').select('users.fullname, tasks.*')
    t.group_by(&:fullname)
  end
  def self.all_active_by_requester
    t = self.where("tasks.complete IS NOT 't' AND tasks.requester_id IS NOT NULL").order("users.fullname, tasks.id").joins('INNER JOIN users ON users.id = tasks.requester_id').select('users.fullname, tasks.*')
    t.group_by(&:fullname)
  end
  def self.all_active_manual_sort(id)
    t = self.where("tasks.complete = 'f' AND tasks.assignee_id = ?", id).order("users.fullname, tasks.priority").joins('INNER JOIN users ON users.id = tasks.assignee_id').select('users.fullname, tasks.*')
  end
end
