class Project < ActiveRecord::Base
  
  def self.k_proj
      self.order("tapeout").where("key = 't'")
  end
end
