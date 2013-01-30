class SetupSyncController < ApplicationController
  def index
  end
  def prr
    #Create product family array and get all devices from setup.txt that match
    @wire2 = Device.get_family("2W")
    @list = @wire2.map {|i| i.name }
    @device_setups = Setup.get_setups_magnum(@list)
    #specific program queries
    @targets_default = Target.defaults("2W")
    @targets_device = Target.device("2W")
    @targets_device_tab = Target.device_tab("2W")
  end
  
end
