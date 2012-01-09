class MainController < ApplicationController
  before_filter :set_useful_globals

  def index
  end
  
  def project_active
    #@total_task_count=Task.all_active.count
    @tasks = Task.all_active2
  end

  def project_active_past_due
    @tasks=Task.all_active_past_due
  end

  def project_completed
    @supress_overdue_color = true
    @tasks=Task.all_completed
  end

  def project_unassigned
    @tasks=Task.all_unassigned
  end
  
  def email_user_task_report
    @users=User.all
    #loop through users
    @users.each do |u|
      @us=u
      #u=1
      #get 3 queries for report
      @active = Task.all_active_assigned_to(u)
      if @active.count >0

        UserMailer.daily_report(u,@active).deliver
      end
    end
  end
  
  def project_my_active
    @users=User.all
    @tasks=Task.all_my_active(@user_id)
    @tasks_by_me=Task.all_my_active_by_me(@user_id)
  end
  
  def project_my_active_past_due
    @users=User.all
    @tasks=Task.all_my_active_past_due(@user_id)
  end

  def pto_current
    @outlook = 30
    @start=@today
    @stop = @start+ @outlook
    @ptos=Pto.upcoming_range(@start,@stop)
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
