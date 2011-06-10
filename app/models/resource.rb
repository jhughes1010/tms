class Resource < ActiveRecord::Base
  
  def self.sapphire(date)
    find(:all, :conditions =>["project = 'Sapphire' AND date >= ? AND date < ?" , date, date +15.months], :order =>"date", :select => "sum (forecast) as forecast", :group => "date")
  end
  def self.sapphire_sub(date)
    find(:all, :conditions =>["project = 'Sapphire' AND date >= ? AND date < ?" , date, date +15.months], :order =>"date", :select => "sum (forecast) as forecast", :group => "date")
  end
end
