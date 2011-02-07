class Pto < ActiveRecord::Base
  def self.all_by_date
    find(:all, :order =>"start")
  end
  
  def self.upcoming_range(st,fi)
    find(:all, :order =>"start,user_id", :conditions => ["(start >= ? or end >= ?) and start < ?", st, st, fi])
  end
end
