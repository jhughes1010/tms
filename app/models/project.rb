class Project < ActiveRecord::Base
  
  def self.k_proj(date)
  Resource.where("resources.date >= ? AND resources.date < ?" , date, date +15.months).select("projects.id, projects.long_name, projects.owner, projects.dr1, projects.dr2, projects.dr3, projects.dr4, projects.dr5, resources.project, sum (resources.forecast) as forecast").group("resources.project").order("forecast DESC").joins('INNER JOIN projects ON projects.project = resources.project')
  end
  
  def self.all_proj
    self.order("owner, key DESC, tapeout")
  end
end
