class TasksController < ApplicationController
  # GET /tasks
  # GET /tasks.xml
  def index
    @tasks = Task.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks }
    end
  end
  
  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    @auth = session[:user_auth]
    @task = Task.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end
  
  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @full_name=session[:user_fullname]
    @user_id=session[:user_id]
    @auth=session[:auth_level]
    @requesters=User.requester_list
    @assignees=User.assignee_list
    @task = Task.new
    
    respond_to do |format| 
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end
  
  # GET /tasks/1/edit
  def edit
    @auth = session[:user_auth]
    @requesters=User.requester_list
    @assignees=User.assignee_list
    @task = Task.find(params[:id])
  end
  
  # POST /tasks
  # POST /tasks.xml
  def create
    @full_name=session[:user_fullname]
    @task = Task.new(params[:task])
    #deliver the mail
    UserMailer.task_entry_confirmation(session[:user_id],@task).deliver
    UserMailer.task_entry_confirmation(1,@task).deliver
    
    respond_to do |format|
      if @task.save
        format.html { redirect_to(@task, :notice => 'Task was successfully created.') }
        format.xml  { render :xml => @task, :status => :created, :location => @task }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
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
end
