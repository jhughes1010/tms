class CanMainsController < ApplicationController
  # GET /can_mains
  # GET /can_mains.xml
  def index
    @can_mains = CanMain.can

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @can_mains }
    end
  end

  # GET /can_mains/1
  # GET /can_mains/1.xml
  def show
    @can_main = CanMain.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @can_main }
    end
  end

  # GET /can_mains/new
  # GET /can_mains/new.xml
  def new
    @can_main = CanMain.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @can_main }
    end
  end

  # GET /can_mains/1/edit
  def edit
    @can_main = CanMain.find(params[:id])
  end

  # POST /can_mains
  # POST /can_mains.xml
  def create
    @can_main = CanMain.new(params[:can_main])

    respond_to do |format|
      if @can_main.save
        format.html { redirect_to(@can_main, :notice => 'Can main was successfully created.') }
        format.xml  { render :xml => @can_main, :status => :created, :location => @can_main }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @can_main.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /can_mains/1
  # PUT /can_mains/1.xml
  def update
    @can_main = CanMain.find(params[:id])

    respond_to do |format|
      if @can_main.update_attributes(params[:can_main])
        format.html { redirect_to(@can_main, :notice => 'Can main was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @can_main.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /can_mains/1
  # DELETE /can_mains/1.xml
  def destroy
    @can_main = CanMain.find(params[:id])
    @can_main.destroy

    respond_to do |format|
      format.html { redirect_to(can_mains_url) }
      format.xml  { head :ok }
    end
  end
end
