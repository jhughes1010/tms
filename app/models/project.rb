class Project < ActiveRecord::Base

  def self.k_proj
    self.order("tapeout").where("key = 't'")
  end
  def self.all_proj
    self.order("owner, key DESC, tapeout")
  end
end
