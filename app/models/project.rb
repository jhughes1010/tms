class Project < ActiveRecord::Base

  def self.k_proj
    self.where("projects.key = 't'").joins('INNER JOIN projects ON projects.project = resources.project').select('projects.project, resources.forecast')
    #'INNER JOIN users ON users.id = tasks.requester_id'
  end
  def self.all_proj
    self.order("owner, key DESC, tapeout")
  end
end
