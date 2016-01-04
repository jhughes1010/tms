class UsersController < ApplicationController
  
  
  before_filter :set_useful_globals
  
  # GET /users
  # GET /users.xml
  def roster
    @title = "Team Roster"
    if @team == "Crypto"
    @users = User.crypto.order("department, fullname")
  elsif @team == "Memory"
    @users = User.memory
  end
  render "index"
  end
  
  def index
    @title = "All Users"
    @users = User.find(:all, :order => "department, fullname") ##jh department, name")
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end
  
  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  # GET /users/1/edit
  def edit
    @auth = session[:user_auth]
    if @auth < 2
       flash.now[:notice]="Invalid privilidges"
       redirect_to(:action => "/users/index")
    end
    @user = User.find(params[:id])
  end
  
  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    
    respond_to do |format|
      if @user.save
        #deliver the mail
        UserMailer.registration_confirmation(@user).deliver
        flash[:notice]= "User #{@user.name} was successfully created."
        format.html { redirect_to(:action=>'index') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])
    #deliver the mail
    #UserMailer.registration_confirmation(@user).deliver
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice]= "User #{@user.name} was successfully updated."
        format.html { redirect_to(:action=>'index') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    
    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  #
  #email debug
  
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
