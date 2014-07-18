class TestTimesController < ApplicationController
  # GET /test_times
  # GET /test_times.xml
  def index
    @test_times = TestTime.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @test_times }
    end
  end

  # GET /test_times/1
  # GET /test_times/1.xml
  def show
    @test_time = TestTime.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @test_time }
    end
  end

  # GET /test_times/new
  # GET /test_times/new.xml
  def new
    @test_time = TestTime.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @test_time }
    end
  end

  # GET /test_times/1/edit
  def edit
    @test_time = TestTime.find(params[:id])
  end

  # POST /test_times
  # POST /test_times.xml
  def create
    @test_time = TestTime.new(params[:test_time])

    respond_to do |format|
      if @test_time.save
        format.html { redirect_to(@test_time, :notice => 'Test time was successfully created.') }
        format.xml  { render :xml => @test_time, :status => :created, :location => @test_time }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @test_time.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /test_times/1
  # PUT /test_times/1.xml
  def update
    @test_time = TestTime.find(params[:id])

    respond_to do |format|
      if @test_time.update_attributes(params[:test_time])
        format.html { redirect_to(@test_time, :notice => 'Test time was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @test_time.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /test_times/1
  # DELETE /test_times/1.xml
  def destroy
    @test_time = TestTime.find(params[:id])
    @test_time.destroy

    respond_to do |format|
      format.html { redirect_to(test_times_url) }
      format.xml  { head :ok }
    end
  end
end
