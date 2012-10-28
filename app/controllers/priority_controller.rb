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
        #get scd and duration for first entry for date completion estimates
        date_complete = @today
        tasks.each do |t|
          puts t.duration.class
          #is duration invalid?
          if t.duration.nil?
            t.duration = 0
          end
          duration = t.duration*7
          t.scd = date_complete.next_day( duration )
          t.priority=priority
          t.save
          #update variables for next record
          date_complete = t.scd
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
