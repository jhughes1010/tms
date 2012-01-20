class ResourceController < ApplicationController
  require "csv"

  before_filter :set_useful_globals

  def index
    #Work through projects
    @key_projects = Project.k_proj
    @project="SinbadEE"
    @project_totals = project_totals(@project)
  end
  #Key Project Index
  def key_projects
    @key_projects = Project.k_proj
  end
  #Key Project Summary
  def key_project_summary
    if params[:p_id]
      p=params[:p_id].to_i
      @key_projects = Project.find(p)
      @dr_month = find_dr_offset(@key_projects)
      @project_totals = project_totals(@key_projects.project)
      #Get Department Totals
      @layout = department_totals(@key_projects.project,"Layout")
      @design = department_totals(@key_projects.project,"Design")
      @pe = department_totals(@key_projects.project,"Product")
      @application = department_totals(@key_projects.project,"Applications")
      #Get Department Details
      @all_details = Resource.project_detail_name(@today.at_beginning_of_month,@key_projects.project)
    end
  end
  def employee_view
    employee_name = params[:name]
    start_date = @today.beginning_of_month
    @resources = Resource.tasks_by(employee_name, start_date)
  end
  def actual
    start_date = @today.beginning_of_month.months_ago(3)
    @key_projects = Project.k_proj
    @avf = Resource.avf(start_date,3)
  end
  
  def project_totals_wip(project)
    #Project Totals
    #project_totals = Array.new(17,0)
    @date_start = @today.at_beginning_of_month
    #dummy = Resource.project_detail(@date_start,project)
    #count = dummy.count
    #puts count
    #puts dummy
    total = Resource.project_total(@date_start,project)
    unless count < 15
      0.upto(14){
        |x|
        project_totals[x] = total[x].forecast
        project_totals[15] += total[x].forecast
        puts project_totals[x]
      }
      project_totals[16] = project_totals[15]/12
    end
    project_totals
  end
  def project_totals(project)
    #Project Totals
    project_totals = Array.new(17,0)
    @date_start = @today.at_beginning_of_month
    dummy = Resource.project_detail(@date_start,project)
    count = dummy.count
    #puts count
    #puts dummy
    total = Resource.project_total(@date_start,project)
    unless count < 15
      0.upto(14){
        |x|
        project_totals[x] = total[x].forecast
        project_totals[15] += total[x].forecast
        puts project_totals[x]
      }
      project_totals[16] = project_totals[15]/12
    end
    project_totals
  end
  def department_totals(project,department)
    #Department Totals
    @date = @today
    dept_totals = Array.new(17,0)
    @date_start = @date.at_beginning_of_month
    dummy = Resource.department_detail(@date_start,project, department)
    count = dummy.count
    puts count
    total = Resource.department_total(@date_start,project, department)
    unless count < 15
      0.upto(14){
        |x|
        dept_totals[x] = total[x].forecast
        dept_totals[15] += total[x].forecast  if  total[x].forecast
      }
      dept_totals[16] = dept_totals[15]/12
    end
    dept_totals
    #end
  end
  #
  #
  #
  def import
    #initial variables
    header = 0
    #filenames
    import_file = "import/2011q4.csv"
    puts
    puts "============================================="
    puts "CSV importer for Resource Allocation database"
    puts "Resource List Import tool"
    puts "============================================="
    #import and stack data
    #delete database
    Resource.delete_all
    arr_of_arrs = CSV.read(import_file)
    arr_of_arrs.each do |x|
      stack_data(x) if header == 1
      header = 1 if header == 0
    end
  end
  #no longer needed as projects are in the database
  def dnu_import_project
    #initial variables
    header = 0
    #filenames
    import_file = "import/project_list.csv"
    puts
    puts "============================================="
    puts "CSV importer for Resource Allocation database"
    puts "Project List Import tool"
    puts "============================================="
    #delete database
    Project.delete_all
    arr_of_arrs = CSV.read(import_file)
    arr_of_arrs.each do |x|
      write_project_record(x) if header == 1
      header = 1 if header == 0
    end
  end
  #
  #
  #
  def stack_data(line)
    write_record(line)
    update_record(line)
  end
  #
  #
  #
  def write_record(record)
    #write new record to database
    date_start = @today.at_beginning_of_month - 3.months
    8.upto(25){
      |x|
      #work through forecast data
      if x < 8
        print ":Actual   "
      else
        #print ":Forecast "
        date_current=date_start.months_since(x-8)
        if record[x].nil?
          record[x]=0
        end
        new_to_db(date_current,record[0], record[1],record[2],record[3],record[4],record[x])
      end
    }
  end

  def update_record  (record)
    date_start = @today.at_beginning_of_month - 3.months
    0.upto(2){
      |m|
      date_current=date_start.months_since(m)
      find_record_enter_actual(date_current,record[0], record[1],record[3],record[4],record[m+5])
    }
  end

  #Write the project.csv file to the project.db
  #def write_project_record(record)
  # new_to_project_db(record[0], record[1],record[2],record[3],record[4],record[5],record[6],record[7])
  #end
  #
  #
  #
  def new_to_db(date,dept,name,overbook,project,function,time)
    record = Resource.new
    if time.nil?
      time = 0
    end
    record.date = date
    record.name = name
    record.department = dept
    record.project = project
    record.function = function
    record.actual = 0
    record.forecast = time
    record.save
  end
  def find_record_enter_actual(date,dept,name,project,function,time)
    record = Resource.update_actual(date,dept,name,project,function)
    #puts record.count
    puts record.id
    puts record.name
    if time.nil?
      time = 0
    end
    record.actual = time
    record.save
  end

  #
  #
  #
  #
  #
  def new_to_project_db(project,key,tapeout,dr1,dr2,dr3,dr4,dr5)
    record = Project.new
    record.project = project
    record.tapeout = tapeout
    if key == "Y"
      record.key = true
    else
      record.key = false
    end

    record.dr1 = dr1
    record.dr2 = dr2
    record.dr3 = dr3
    record.dr4 = dr4
    record.dr5 = dr5
    record.save
  end

  def find_dr_offset(project)
    dr_month_array = Array.new(5)
    #today = Date.today
    beginning_of_month = @today.beginning_of_month
    dr5_m = project.dr5.beginning_of_month if project.dr5 != nil
    dr4_m = project.dr4.beginning_of_month if project.dr4 != nil
    dr3_m = project.dr3.beginning_of_month if project.dr3 != nil
    dr2_m = project.dr2.beginning_of_month if project.dr2 != nil
    dr1_m = project.dr1.beginning_of_month if project.dr1 != nil

    0.upto(14) {
      |m|
      projected_date = beginning_of_month.months_since(m)
      if dr5_m == projected_date
        dr_month_array[4]=m
      elsif dr4_m == projected_date
        dr_month_array[3]=m
      elsif dr3_m == projected_date
        dr_month_array[2]=m
      elsif dr2_m == projected_date
        dr_month_array[1]=m
      elsif dr1_m == projected_date
        dr_month_array[0]=m
      end
    }
    dr_month_array
  end

  protected

  def set_useful_globals
    @auth = session[:user_auth]
    @user_id=session[:user_id]
    @full_name=session[:user_fullname]
    @today=Date.today
    @today.to_s(:long)
  end
end
