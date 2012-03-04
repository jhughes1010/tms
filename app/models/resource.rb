class Resource < ActiveRecord::Base

  def self.project_total(date,project)
    self.where("project = ? AND date >= ? AND date < ?" ,project, date, date +15.months).order("date").select("date, sum (forecast) as forecast").group("date")
  end
  def self.project_detail(date,project)
    self.where("project = ? AND date >= ? AND date < ?" ,project, date, date +15.months).order("date")
  end
  def self.project_detail_name(date,project)
    self.where("project = ? AND date >= ? AND date < ?" ,project, date, date +15.months).group("project", "department", "name", "function").order("project", "department","name","function").select("project, department, name, function")
  end
  def self.department_total(date,project,department)
    self.where("project = ? AND department LIKE ? AND date >= ? AND date < ?" ,project, "%#{department}%", date, date +15.months).order("date").select("date, sum (forecast) as forecast").group("date")
  end
  def self.department_actual_total(date,project,department)
    self.where("project = ? AND department LIKE ? AND date < ?" ,project, "%#{department}%", date).order("date").select("date, sum (actual) as actual").group("date")
  end
  def self.department_detail(date,project,department)
    self.where("project = ? AND department LIKE ? AND date >= ? AND date < ?" ,project, "%#{department}%", date, date +15.months).order("date")
  end
  def self.get_month(project,department,name,function,today,date_offset)
    date=today.beginning_of_month + date_offset.months
    self.where("project = ? AND department = ? AND name = ? AND function = ? AND date = ?" ,project, department,name,function, date)
  end
  def self.tasks_by(employee_name, date)
    t = self.where("name = ? AND date >= ? AND date < ?", employee_name, date, date+15.months).order("project, function, date")
    t.group_by(&:project)
  end
  def self.update_actual(date,dept,name,project,function)
    self.where("date = ? AND department = ? and name = ? AND project = ? AND function = ?",date,dept,name,project,function).first
  end
  def self.avf(start, span)
    self.where("date >= ? AND date < ?" ,start, start +span.months).order("department, project").select("department,project, sum (forecast) as forecast, sum (actual) as actual").group("project, department")   
  end
  def self.remove_forecast(date)
    self.delete_all(["date >= ?",date])
  end
  
end
