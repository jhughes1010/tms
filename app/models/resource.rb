class Resource < ActiveRecord::Base

  def self.project_total(date,project)
    self.where("project = ? AND date >= ? AND date < ? AND forecast > 0" ,project, date, date +15.months).order("date").select("date, sum (forecast) as forecast").group("date")
  end

  def self.project_department_total(date,project)
    self.where("project = ? AND date >= ? AND date < ? AND forecast > 0" ,project, date, date +15.months).order("date, department").select("department, date, sum (forecast) as forecast").group("date, department")
  end

  def self.project_total_actuals(date,project)
    self.where("project = ? AND date < ? AND actual > 0" ,project, date).order("date").select("date, department, sum (actual) as actual").group("date")
  end

  def self.project_detail(date,project)
    self.where("project = ? AND date >= ? AND date < ?" ,project, date, date +15.months).order("date")
  end
  def self.project_first(project)
    first_record = self.where("project = ? AND actual > 0", project).order("date").limit(1)
    first_record[0].date
  end
  def self.project_last(project)
    last_record = self.where("project = ? AND forecast > 0", project).order("date DESC").limit(1)
    last_record[0].date
  end
  def self.project_detail_name(date,project)
    self.where("project = ? AND date >= ? AND date < ?" ,project, date, date +15.months).group("project", "department", "name", "function").order("project", "department","name","function").select("project, department, name, function")
  end
  def self.department_total(date,project,department)
    self.where("project = ? AND department IN (?) AND date >= ? AND date < ?" ,project, department, date, date +15.months).order("date").select("date, sum (forecast) as forecast").group("date")
  end
  def self.department_actual_total(date,project,department)
    self.where("project = ? AND department LIKE ? AND date < ?" ,project, "%#{department}%", date).order("date").select("date, sum (actual) as actual").group("date")
  end
  def self.department_detail(date,project,department)
    self.where("project = ? AND department IN (?) AND date >= ? AND date < ?" ,project, department, date, date +15.months).order("date")
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
  def   self.total_forecast_man_hours(date)
    self.where("date >= ? AND date < ?" ,date, date +15.months).select("sum (forecast) as forecast")
  end


  def   self.all_actuals
    date = Time.parse('2011-01-01')
    #self.where("actual > 0 AND date >= ? AND date < ?" ,date, date +12.months).select("project, department, sum (actual) as actual").group("project").order("project")
    #self.where("actual > 0 AND date >= ? AND date < ?" ,date, date +12.months).select("project, department, sum (actual) as actual").group("project, department").order("project, department")
    self.where("actual > 0 AND date >= ? AND date < ?" ,date, date +12.months).select("project, department, date, sum (actual) as actual").group("project, department, date").order("project, department, date")
  end

  def self.overbooked
    t = self.select("department, name, date, sum(forecast) as forecast").where("forecast > 1").group("name,date").order("department, name, date")
    #t.group_by(&:department)
  end

  def self.team_names
    t = self.select("department, team").group("department, team")
  end
  
  def self.forward_look_key(date, dept, team)
    proj = Array.new
    kp = Project.k_proj(date)
    kp.each do |p|
      proj << p.project
    end
    t = self.select("department, team, date, sum(forecast) as forecast").where("date >= ? AND project IN (?) AND department = ? AND team LIKE ?",date, proj, dept, team).group("department, date").order("date")
    #t.group_by(&:department)
  end
  
  def self.forward_look_other(date, dept, team)
    proj = Array.new
    kp = Project.k_proj(date)
    kp.each do |p|
      proj << p.project
    end
    t = Hash.new(0)
    t = self.select("department, team, date, sum(forecast) as forecast").where("date >= ? AND project NOT IN (?)",date, proj).group("date, department").order("department")
    #t = self.select("department, team, date, sum(forecast) as forecast").where("project NOT IN (?)",proj).group("department, team, date").order("department, date")
    #t.group_by(&:department)    
  end
end
