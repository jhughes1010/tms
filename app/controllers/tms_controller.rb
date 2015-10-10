class TmsController < ApplicationController
  def viewAll
    @tasks = Task.recent(60)
    #the line below is just to kickstart the cleanup process and not normally used
    #@tasks = Task.completenotaccepted(60)
    
  end
  #sets accepted to TRUE for all tasks marked completed over 60 days ago
  def purgeNotAccepted
    @tasks = Task.completenotaccepted(60)
  end
end
