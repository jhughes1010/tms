class Target < ActiveRecord::Base
  def self.defaults( family )
    t = self.where("family in (?) AND device = 'default'", family).limit(1)
  end
end
