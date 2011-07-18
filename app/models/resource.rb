class Resource < ActiveRecord::Base

  def self.project_total(date,project)
    self.where("project = ? AND date >= ? AND date < ?" ,project, date, date +15.months).order("date").select("sum (forecast) as forecast").group("date")
  end
  def self.project_detail(date,project)
    self.where("project = ? AND date >= ? AND date < ?" ,project, date, date +15.months).order("date")
  end
  def self.department_total(date,project,department)
    self.where("project = ? AND department = ? AND date >= ? AND date < ?" ,project, department, date, date +15.months).order("date").select("sum (forecast) as forecast").group("date")
  end
  def self.department_detail(date,project,department)
    self.where("project = ? AND department = ? AND date >= ? AND date < ?" ,project, department, date, date +15.months).order("date")
  end
end
