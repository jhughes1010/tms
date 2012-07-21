class Project < ActiveRecord::Base
  
  def self.k_proj(date)
  Resource.where("resources.date >= ? AND resources.date < ?" , date, date +15.months).select("projects.id, projects.long_name, projects.owner, projects.dr1, projects.dr2, projects.dr3, projects.dr4, projects.dr5, resources.project, sum (resources.forecast) as forecast").group("resources.project").order("owner, forecast DESC").joins('INNER JOIN projects ON projects.project = resources.project')
  end
  
  def self.all_proj
    self.order("owner, key DESC, tapeout")
  end
  
  def self.not_k_proj(date)
    #proj = ['AT30LD2001']
    proj = Array.new
    kp = Project.k_proj(date)
    kp.each do |p|
    proj << p.project
    end
    #proj = ["AT30LD2001","ATSHA204"]
  t = Resource.select("project, department, name").where("project NOT IN (?)",proj).group("department, project").order("department, project")
  t.group_by(&:department)
  end
  
end
