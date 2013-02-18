class Setup < ActiveRecord::Base
  def self.get_setups_magnum(part)
    
    t = self.where("device in (?) AND platform NOT IN ('EPRO','dualEPRO','quadEPRO')", part).order("device, tab, platform,  location ")
    #t = self.where("device in (?)", part).order("device, platform , tab,  location ")
  end
end
