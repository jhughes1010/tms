class TestProg < ActiveRecord::Base
  def self.live
    self.order("engineer, date_received")
  end

end
