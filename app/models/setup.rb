class Setup < ActiveRecord::Base
  
  attr_reader :match_cp1, :match_cp2, :match_cp3
  
  def self.get_setups_magnum(part)
    
    t = self.where("device in (?) AND platform NOT IN ('EPRO','dualEPRO','quadEPRO')", part).order("device, tab, platform,  location ")
    #t = self.where("device in (?)", part).order("device, platform , tab,  location ")
  end

end
