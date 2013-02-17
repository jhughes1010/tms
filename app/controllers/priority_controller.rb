class PriorityController < ApplicationController

  before_filter :set_useful_globals

  def index
    #Menu page - check auth level
  end

  def project_auto_priority
    unless @auth == 1
      @te = User.get_te
      @tsk = Task.all_active3
      #Spread out priority numbers
      @tsk.each_pair do |assignee_id, tasks|
        priority=1
        first_record_flag = 1
        #get scd and duration for first entry for date completion estimates
        date_complete = Date.today
        tasks.each do |t|
          #update record
          if first_record_flag == 0
            #is duration invalid?
            t.duration = 0 if t.duration.nil?
            duration = t.duration*7
            t.scd = date_complete.next_day( duration )
          elsif
            first_record_flag == 0
            t.scd = @today if t.scd.nil?
            date_complete = t.scd
          end
          t.priority=priority
          t.save
          #update variables for next record
          date_complete = t.scd
          priority = t.priority
          priority +=1

        end
      end
    end
  end

  def   project_manual_priority
    unless @auth == 1
      assignee_id = params[:id]
      @tasks = Task.all_active_manual_sort(assignee_id)
      #@tasks = Task.all_active_manual_sort(1)
    end
  end

  def reorder
    puts "reorder"
    @category_ids = params[:categories]
    n = 0
    ActiveRecord::Base.transaction do
      @category_ids.each do |id|
        category = Task.find(id)
        category.priority = n
        n += 1
        category.save
      end
    end
    render :json => {}
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
