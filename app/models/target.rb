class Target < ActiveRecord::Base
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
end
