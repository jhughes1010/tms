class SetupSyncController < ApplicationController
  before_filter :set_useful_globals

  def index
  end
  def prr
    @family = params[:family]
    @devices = Device.get_family(@family)
    if request.post?
      @list = params[:device].upcase
    elsif
      @list = @devices.map {|i| i.name }
    end
    @device_setups = Setup.get_setups_magnum(@list)
  end
  def report
    @report = params[:report]

      if @report == "RED"
            @device_setups = Setup.get_setups_red
      elsif @report == "EPRO"
      end
  end
  protected

  def set_useful_globals
    @auth = session[:user_auth]
    @user_id=session[:user_id]
    @full_name=session[:user_fullname]
    @today=Date.today
    @today.to_s(:long)
  end

end
