class PriorityController < ApplicationController
  
  before_filter :set_useful_globals
  
  def index
    #Menu page - check auth level
  end
  
  def project_auto_priority
    unless @auth == 1
      #@today=Date.today
      #@today.to_s(:long)
      @te = User.get_te
      @tsk = Task.all_active3
      #Spread out priority numbers
      @tsk.each_pair do |assignee_id, tasks|
        priority=2
        tasks.each do |t|
          t.priority=priority
          t.save
          priority +=3
        end
      end
    end
  end
  
  def   project_manual_priority
    @tasks = Task.all_active_by_requester
    
    
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
