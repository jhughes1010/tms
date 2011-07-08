class CanSubsController < ApplicationController
  # GET /can_subs
  # GET /can_subs.xml
  def index
    @can_subs = CanSub.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @can_subs }
    end
  end

  # GET /can_subs/1
  # GET /can_subs/1.xml
  def show
    @can_sub = CanSub.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @can_sub }
    end
  end

  # GET /can_subs/new
  # GET /can_subs/new.xml
  def new
    @can_sub = CanSub.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @can_sub }
    end
  end

  # GET /can_subs/1/edit
  def edit
    @can_sub = CanSub.find(params[:id])
  end

  # POST /can_subs
  # POST /can_subs.xml
  def create
    @can_sub = CanSub.new(params[:can_sub])

    respond_to do |format|
      if @can_sub.save
        format.html { redirect_to(@can_sub, :notice => 'Can sub was successfully created.') }
        format.xml  { render :xml => @can_sub, :status => :created, :location => @can_sub }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @can_sub.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /can_subs/1
  # PUT /can_subs/1.xml
  def update
    @can_sub = CanSub.find(params[:id])

    respond_to do |format|
      if @can_sub.update_attributes(params[:can_sub])
        format.html { redirect_to(@can_sub, :notice => 'Can sub was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @can_sub.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /can_subs/1
  # DELETE /can_subs/1.xml
  def destroy
    @can_sub = CanSub.find(params[:id])
    @can_sub.destroy

    respond_to do |format|
      format.html { redirect_to(can_subs_url) }
      format.xml  { head :ok }
    end
  end
end
