class TmsController < ApplicationController
  def viewAll
    @tasks = Task.recent(7)
    #the line below is just to kickstart the cleanup process and not normally used
    #@tasks = Task.completenotaccepted(60) 
    ###@tasks = Task.gerald(49)   
  end
end
