class TasksController < ApplicationController
  
  before_filter :set_useful_globals
  
  # GET /tasks
  # GET /tasks.xml
  def index
    @tasks = Task.order(:id)

    respond_to do |format|
      format.html # index.html.erb
      #format.xml  { render :xml => @tasks }
      format.csv { send_data @tasks.as_csv }
      #format.csv { render text: @tasks.as_csv }
      format.xls { send_data @tasks.as_csv(col_sep: "\t") }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @requesters=User.requester_list
    @assignees=User.assignee_list
    @unassigned_user_id = User.unassigned_id
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @requesters=User.requester_list
    @assignees=User.assignee_list
    @task = Task.find(params[:id])

    #deliver the mail
    #unless session[:user_id] == 31 || session[:user_id] == 1
    #  UserMailer.task_edit_confirmation(session[:user_id],@task).deliver
    #  UserMailer.task_edit_confirmation(1,@task).deliver
    #end
  end

  # GET /tasks/1/duplicate
  def duplicate
    task = Task.find(params[:id])
    copy = task.dup
    copy.id = nil
    copy.save
    
    #deliver the mail
    UserMailer.task_entry_confirmation(session[:user_id],copy).deliver
    UserMailer.task_entry_confirmation(1,copy).deliver    #James Hughes
    UserMailer.task_entry_confirmation(31,copy).deliver   #Michael Flanagan (yes this is bad, fix it)   
    UserMailer.task_entry_confirmation(65,copy).deliver   #John Groat (yes this is bad, fix it)   
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    @task = Task.new(params[:task])
    
    respond_to do |format|
      if @task.save
        format.html { redirect_to(@task, :notice => 'Task was successfully created.') }
        format.xml  { render :xml => @task, :status => :created, :location => @task }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
    #deliver the mail
    UserMailer.task_entry_confirmation(session[:user_id],@task).deliver
    UserMailer.task_entry_confirmation(1,@task).deliver
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to(@task, :notice => 'Task was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to(tasks_url) }
      format.xml  { head :ok }
    end
  end
  #mark closed flag as TRUE and accepted flag as FALSE
  def close
    @task = Task.find(params[:id])
    
  end

  #mark closed flag as TRUE and accepted flag as TRUE  
  def accept
    @task = Task.find(params[:id])
    
    
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
