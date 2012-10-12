class TestProg < ActiveRecord::Base
  def self.live
    self.order("operation, date_received")
  end

end
