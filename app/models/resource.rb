class Resource < ActiveRecord::Base

  def self.project_total(date,project)
    self.where("project = ? AND date >= ? AND date < ?" ,project, date, date +15.months).order("date").select("sum (forecast) as forecast").group("date")
  end
  def self.project_detail(date,project)
    self.where("project = ? AND date >= ? AND date < ?" ,project, date, date +15.months).order("date")
  end
  def self.project_detail_name(date,project)
    self.where("project = ? AND date >= ? AND date < ?" ,project, date, date +15.months).order("date").group("project", "department", "name", "function").order("department","name","function").select("department, name, function, project, date")
  end
  def self.department_total(date,project,department)
    self.where("project = ? AND department LIKE ? AND date >= ? AND date < ?" ,project, "%#{department}%", date, date +15.months).order("date").select("sum (forecast) as forecast").group("date")
  
  end
  def self.department_detail(date,project,department)
    self.where("project = ? AND department LIKE ? AND date >= ? AND date < ?" ,project, "%#{department}%", date, date +15.months).order("date")
  end
  def self.get_month(project,department,name,function,date_offset)
    date=Date.today.beginning_of_month + date_offset.months
    self.where("project = ? AND department = ? AND name = ? AND function = ? AND date = ?" ,project, department,name,function, date)
  end
end
