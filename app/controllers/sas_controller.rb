class SasController < ApplicationController
  # GET /sas
  # GET /sas.xml
  def index
    @sas = Sa.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sas }
    end
  end

  # GET /sas/1
  # GET /sas/1.xml
  def show
    @sa = Sa.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sa }
    end
  end

  # GET /sas/new
  # GET /sas/new.xml
  def new
    @sa = Sa.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sa }
    end
  end

  # GET /sas/1/edit
  def edit
    @sa = Sa.find(params[:id])
  end

  # POST /sas
  # POST /sas.xml
  def create
    @sa = Sa.new(params[:sa])

    respond_to do |format|
      if @sa.save
        format.html { redirect_to(@sa, :notice => 'Sa was successfully created.') }
        format.xml  { render :xml => @sa, :status => :created, :location => @sa }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sa.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sas/1
  # PUT /sas/1.xml
  def update
    @sa = Sa.find(params[:id])

    respond_to do |format|
      if @sa.update_attributes(params[:sa])
        format.html { redirect_to(@sa, :notice => 'Sa was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sa.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sas/1
  # DELETE /sas/1.xml
  def destroy
    @sa = Sa.find(params[:id])
    @sa.destroy

    respond_to do |format|
      format.html { redirect_to(sas_url) }
      format.xml  { head :ok }
    end
  end
end
