class CanMain < ActiveRecord::Base
  
  
  def self.can
      self.order("can")
  end
end
