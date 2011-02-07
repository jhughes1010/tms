class PtosController < ApplicationController
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

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pto }
    end
  end

  # GET /ptos/1/edit
  def edit
    @pto = Pto.find(params[:id])
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
end
