class SetupSyncController < ApplicationController
  def index
  end
  def prr
    @targets = Target.defaults("2W")
    @wire2 = Device.get_family("2W")
    @list = @wire2.map {|i| i.name }
    @device_setups = Setup.get_setups_magnum(@list)
    #@device_setups = Setup.get_setups(["35815", "35833"])
  end
  
end
