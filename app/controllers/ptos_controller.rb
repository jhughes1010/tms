class PtosController < ApplicationController
  before_filter :set_useful_globals
  
  # GET /ptos
  # GET /ptos.xml
  def index
    @ptos = Pto.all_by_date

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ptos }
    end
  end

  # GET /ptos/1
  # GET /ptos/1.xml
  def show
    @pto = Pto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pto }
    end
  end

  # GET /ptos/new
  # GET /ptos/new.xml
  def new
    @pto = Pto.new
    @assignees=User.assignee_list
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pto }
    end
  end

  # GET /ptos/1/edit
  def edit
    @pto = Pto.find(params[:id])
    @assignees=User.assignee_list
  end

  # POST /ptos
  # POST /ptos.xml
  def create
    @pto = Pto.new(params[:pto])

    respond_to do |format|
      if @pto.save
        format.html { redirect_to(@pto, :notice => 'Pto was successfully created.') }
        format.xml  { render :xml => @pto, :status => :created, :location => @pto }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pto.errors, :status => :unprocessable_entity }
      end
    end
    #deliver the mail to requester
    UserMailer.pto_entry_confirmation(session[:user_id], session[:user_id], @pto).deliver
    #deliver the mail to James
    UserMailer.pto_entry_confirmation(1, session[:user_id], @pto).deliver
  end

  # PUT /ptos/1
  # PUT /ptos/1.xml
  def update
    @pto = Pto.find(params[:id])

    respond_to do |format|
      if @pto.update_attributes(params[:pto])
        format.html { redirect_to(@pto, :notice => 'Pto was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pto.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ptos/1
  # DELETE /ptos/1.xml
  def destroy
    @pto = Pto.find(params[:id])
    @pto.destroy

    respond_to do |format|
      format.html { redirect_to(ptos_url) }
      format.xml  { head :ok }
    end
  end
  
  protected

  def set_useful_globals
    @auth = session[:user_auth]
    @user_id=session[:user_id]
    @full_name=session[:user_fullname]
    now = Date.today.beginning_of_month
    now_month = (now.month) - 1
    now_offset = now_month.modulo(3)
    @today=now.months_ago(now_offset)
    @today.to_s(:long)
    #@today.beginning_of_month
  end
  
end
