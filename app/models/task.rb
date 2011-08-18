class Task < ActiveRecord::Base
  belongs_to :requester, :class_name=>"User"
  belongs_to :assignee, :class_name=>"User"

  scope :grouped, group(:assignee_id)


  def self.all_active
    find(:all, :order =>"assignee_id, priority", :conditions => ["complete = ?",false])
  end
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
    find(:all, :order =>"assignee_id, priority", :conditions => ["requester = ? AND complete = ?",u,false])
  end
  def self.all_my_active_by_me(user_id)
    self.where("complete = ? AND requester_id = ?",false, user_id).order("assignee_id, priority")
  end
  def self.all_active2
    t = self.where("complete = 'f' AND assignee_id IS NOT NULL ").order("assignee_id, priority")
    t.group_by(&:assignee_id)
  end
  def self.all_active3
    t = self.where("complete = 'f' AND assignee_id IS NOT NULL AND priority < 99 ").order("assignee_id, priority, scd")
    t.group_by(&:assignee_id)
  end
end
