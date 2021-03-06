class MainController < ApplicationController

  require "csv"

  before_filter :set_useful_globals

  def index
  end

  def project_active
    @tasks = Task.all_active2
    @tasksCategoryCount = Array.new
    #@tasksCategoryCount[1] = Task.categoryCount(1)
    #@tasksCategoryCount[2] = Task.categoryCount(2)
    #@tasksCategoryCount[3] = Task.categoryCount(3)
    #@tasksCategoryCount[4] = Task.categoryCount(4)
  end

  def project_active_90
    @tasks = Task.all_active2_90
    @tasksCategoryCount = Array.new
    @tasksCategoryCount[1] = Task.categoryCount90(1)
    @tasksCategoryCount[2] = Task.categoryCount90(2)
    @tasksCategoryCount[3] = Task.categoryCount90(3)
    @tasksCategoryCount[4] = Task.categoryCount90(4)
  end

  def project_active_by_requester
    @tasks = Task.all_active_by_requester
  end

  def project_active_past_due
    @tasks=Task.all_active_past_due
  end

  def project_completed
    @supress_overdue_color = true
    @tasks=Task.all_completed
  end

  def project_unassigned
    #reassign all unassigned tasks to Z_staged
    @tasks=Task.all_unassigned
    @unassigned_user_id = User.unassigned_id
    @tasks.each do |t|
      task = Task.find(t.id)
      task.assignee_id = @unassigned_user_id
      task.save
    end
    @tasks=Task.all_for_id(@unassigned_user_id)    
  end

  def email_user_task_report
    @users=User.all
    #loop through users
    @users.each do |u|
      #@us=u
      #u=1
      #get 3 queries for report
      #active
      review = Task.all_active_requested_by(u)
      #closed
    
      if review.count >0

        UserMailer.daily_report(u,review).deliver
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
    @passport_outlook = 9 #months
    @passport_date = @today + @passport_outlook.months
    @passports = User.passports(@passport_date)
  end

  def export_to_csv
    @tasks = Task.all_active
    csv_string = CSV.generate do |csv|
      # header row
      csv << ["ID", "Requester","Assignee","Priority", "Category","Device","Test Point","Platform","Task Name", "Sch Comp Date", "Duration"]

      # data rows
      @tasks.each do |task|
        t = task.assignee ? task.assignee.fullname : "UNASSIGNED" 
        csv << [task.id, task.requester.fullname, t, task.priority, task.category, task.device, task.operation, task.platform, task.taskname, task.scd, task.duration]
      end
    end

    # send it to the browsah
    send_data csv_string,
    :type => 'text/csv; charset=iso-8859-1; header=present',
    :disposition => "attachment; filename=tasks.csv"
  end

  protected

  def set_useful_globals
    @auth = session[:user_auth]
    @user_id=session[:user_id]
    @full_name=session[:user_fullname]
    @team = session[:user_team]
    @today=Date.today
    @today.to_s(:long)
  end
end
