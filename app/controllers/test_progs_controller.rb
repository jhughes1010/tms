class TestProgsController < ApplicationController
  # GET /test_progs
  # GET /test_progs.xml
  def index
    @test_progs = TestProg.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @test_progs }
    end
  end

  # GET /test_progs/1
  # GET /test_progs/1.xml
  def show
    @test_prog = TestProg.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @test_prog }
    end
  end

  # GET /test_progs/new
  # GET /test_progs/new.xml
  def new
    @test_prog = TestProg.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @test_prog }
    end
  end

  # GET /test_progs/1/edit
  def edit
    @test_prog = TestProg.find(params[:id])
  end

  # POST /test_progs
  # POST /test_progs.xml
  def create
    @test_prog = TestProg.new(params[:test_prog])

    respond_to do |format|
      if @test_prog.save
        format.html { redirect_to(@test_prog, :notice => 'Test prog was successfully created.') }
        format.xml  { render :xml => @test_prog, :status => :created, :location => @test_prog }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @test_prog.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /test_progs/1
  # PUT /test_progs/1.xml
  def update
    @test_prog = TestProg.find(params[:id])

    respond_to do |format|
      if @test_prog.update_attributes(params[:test_prog])
        format.html { redirect_to(@test_prog, :notice => 'Test prog was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @test_prog.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /test_progs/1
  # DELETE /test_progs/1.xml
  def destroy
    @test_prog = TestProg.find(params[:id])
    @test_prog.destroy

    respond_to do |format|
      format.html { redirect_to(test_progs_url) }
      format.xml  { head :ok }
    end
  end
end
