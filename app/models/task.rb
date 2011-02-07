class Task < ActiveRecord::Base
  def self.all_active
    find(:all, :order =>"assignee, priority", :conditions => ["complete = ?",false])
  end
  def self.all_my_active(user_id)
    find(:all, :order =>"assignee, priority", :conditions => ["complete = ? AND assignee = ?",false, user_id])
  end

  def self.all_active_past_due
    date=Date.today
    find(:all, :order =>"assignee, priority, scd", :conditions => ["scd < ? and complete = ?", date, false])
  end
  def self.all_my_active_past_due(user_id)
    date=Date.today
    find(:all, :order =>"assignee, priority, scd", :conditions => ["scd < ? and complete = ? and assignee = ?", date, false,user_id])
  end
  def self.all_completed
    date=Date.today
    find(:all, :order =>"assignee, scd", :conditions => ["complete = ?",  true])
  end
  def self.all_unassigned
    date=Date.today
    find(:all, :order =>"priority" , :conditions => "assignee IS NULL")
  end
  def self.all_active_assigned_to(u)
    find(:all, :order =>"assignee, priority", :conditions => ["requester = ? AND complete = ?",u,false])
  end
end
