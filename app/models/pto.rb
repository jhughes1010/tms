class Pto < ActiveRecord::Base
  def self.all_by_date
    find(:all, :order =>"start")
  end
  
  def self.upcoming_range(st,fi)
    #find(:all, :order =>"start,user_id", :conditions => ["(start >= ? OR end >= ?) AND start < ?", st, st, fi])
    find(:all, :order =>"start,user_id", :conditions => ["start >= ?", st])
  end
end
