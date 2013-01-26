class Setup < ActiveRecord::Base
  def self.get_setups(part)
    
    t = self.where("device in (?) AND platform NOT IN ('EPRO','dualEPRO','quadEPRO')", part).order("platform, device, tab,  location ")
  end
end
