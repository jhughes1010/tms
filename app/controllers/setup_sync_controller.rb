class SetupSyncController < ApplicationController
  def index
  end
  def prr
    @wire2 = Device.get_family("2W")
    @list = @wire2.map {|i| i.name }
    @device_setups = Setup.get_setups(@list)
    #@device_setups = Setup.get_setups(["35815", "35833"])
  end
  
end
