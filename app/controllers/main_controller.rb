class MainController < ApplicationController
  def index
    @full_name=session[:user_fullname]
    @auth = session[:user_auth]
    #email_user_task_report
  end

  def pto_current
    @auth = session[:user_auth]
    @users=User.all
    @outlook = 30
    @start=Date.today
    @stop = @start+ @outlook
    @ptos=Pto.upcoming_range(@start,@stop)
  end

  def project_active
    @auth = session[:user_auth]
    @today=Date.today
    @today.to_s(:long)
    #@users=User.all_order_by_fullname
    #@tasks=Task.all_active
    #@te = User.get_te
    @tasks = Task.where(:complete => false).group_by(&:assignee_id)
  end

  def project_active_past_due
    @auth = session[:user_auth]
    @today=Date.today
    @today.to_s(:long)
    @users=User.all
    @tasks=Task.all_active_past_due
  end

  def project_completed
    @supress_overdue_color = true
    @auth = session[:user_auth]
    @today=Date.today
    @today.to_s(:long)
    @users=User.all
    @tasks=Task.all_completed
  end

  def project_unassigned
    @auth = session[:user_auth]
    @today=Date.today
    @today.to_s(:long)
    @users=User.all
    @tasks=Task.all_unassigned
  end
  def email_user_task_report
    @users=User.all
    #loop through users
    @users.each do |u|
      #u=1
      #get 3 queries for report
      @active = Task.all_active_assigned_to(u)
      if @active.count >0

        ##UserMailer.daily_report(u,@active).deliver
      end
    end
  end
  def project_my_active
    @auth = session[:user_auth]
    @user_id=session[:user_id]
    @full_name=session[:user_fullname]

    @today=Date.today
    @today.to_s(:long)
    @users=User.all
    #tasks assigned to me
    @tasks=Task.all_my_active(@user_id)
    #tasks assigned by me
    @tasks_by_me=Task.all_my_active_by_me(@user_id)

  end
  def project_my_active_past_due
    @auth = session[:user_auth]
    @user_id=session[:user_id]
    @full_name=session[:user_fullname]
    @today=Date.today
    @today.to_s(:long)
    @users=User.all
    @tasks=Task.all_my_active_past_due(@user_id)
  end
end
