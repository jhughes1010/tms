class CostingsController < ApplicationController
  # GET /costings
  # GET /costings.xml
  def index
    @costings = Costing.find(:all, :limit => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @costings }
    end
  end

  # GET /costings/1
  # GET /costings/1.xml
  def show
    @costing = Costing.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @costing }
    end
  end

  # GET /costings/new
  # GET /costings/new.xml
  def new
    @costing = Costing.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @costing }
    end
  end

  # GET /costings/1/edit
  def edit
    @costing = Costing.find(params[:id])
  end

  # POST /costings
  # POST /costings.xml
  def create
    @costing = Costing.new(params[:costing])

    respond_to do |format|
      if @costing.save
        format.html { redirect_to(@costing, :notice => 'Costing was successfully created.') }
        format.xml  { render :xml => @costing, :status => :created, :location => @costing }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @costing.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /costings/1
  # PUT /costings/1.xml
  def update
    @costing = Costing.find(params[:id])

    respond_to do |format|
      if @costing.update_attributes(params[:costing])
        format.html { redirect_to(@costing, :notice => 'Costing was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @costing.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /costings/1
  # DELETE /costings/1.xml
  def destroy
    @costing = Costing.find(params[:id])
    @costing.destroy

    respond_to do |format|
      format.html { redirect_to(costings_url) }
      format.xml  { head :ok }
    end
  end
end
