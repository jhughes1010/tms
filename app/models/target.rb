class Target < ActiveRecord::Base
  before_save :programs_uppercase
  
  def self.defaults( family )
    t = self.where("family in (?) AND device = 'default'", family).limit(1)
  end
  def self.device( family )
    t = self.where("family in (?) AND device != '' and tab = 'all'", family)
  end
  def self.device_tab( family )
    t = self.where("family in (?) AND tab != 'all'", family)
  end
  def self.sorted
    t = self.order("family, device, tab")
  end
  private
  def programs_uppercase
    self.mav_cp1.upcase!
    self.mav_cp2.upcase!
    self.mav_cp3.upcase!
    self.mag_cp1.upcase!
    self.mag_cp2.upcase!
    self.mag_cp3.upcase!
    self.mag_x64_cp1.upcase!
    self.mag_x64_cp2.upcase!
    self.mag_x64_cp3.upcase!    
  end
end
