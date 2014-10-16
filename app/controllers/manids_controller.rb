class ManidsController < ApplicationController
  # GET /manids
  # GET /manids.xml
  def index
    @manids = Manid.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @manids }
    end
  end

  # GET /manids/1
  # GET /manids/1.xml
  def show
    @manid = Manid.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @manid }
    end
  end

  # GET /manids/new
  # GET /manids/new.xml
  def new
    @manid = Manid.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @manid }
    end
  end

  # GET /manids/1/edit
  def edit
    @manid = Manid.find(params[:id])
  end

  # POST /manids
  # POST /manids.xml
  def create
    @manid = Manid.new(params[:manid])

    respond_to do |format|
      if @manid.save
        format.html { redirect_to(@manid, :notice => 'Manid was successfully created.') }
        format.xml  { render :xml => @manid, :status => :created, :location => @manid }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @manid.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /manids/1
  # PUT /manids/1.xml
  def update
    @manid = Manid.find(params[:id])

    respond_to do |format|
      if @manid.update_attributes(params[:manid])
        format.html { redirect_to(@manid, :notice => 'Manid was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @manid.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /manids/1
  # DELETE /manids/1.xml
  def destroy
    @manid = Manid.find(params[:id])
    @manid.destroy

    respond_to do |format|
      format.html { redirect_to(manids_url) }
      format.xml  { head :ok }
    end
  end
end
