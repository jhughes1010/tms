class SetupSyncController < ApplicationController
  def index
  end
  def prr
    @family = params[:family]
    @devices = Device.get_family(@family)
    if request.post?
      @list = params[:device].upcase
    elsif
      #Create product family array and get all devices from setup.txt that match
      #@devices = Device.get_family(@family)
      @list = @devices.map {|i| i.name }
    end
    @device_setups = Setup.get_setups_magnum(@list)
    #specific program queries
    @targets_default = Target.defaults(@family)
    @targets_device = Target.device(@family)
    @targets_device_tab = Target.device_tab(@family)
  end

end
