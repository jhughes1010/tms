class ResourceController < ApplicationController
  require "csv"
  require 'google_chart'

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
      #Get Department Totals - Forecast
      @layout = department_totals(@key_projects.project,"Layout")
      @design = department_totals(@key_projects.project,"Design")
      @pe = department_totals(@key_projects.project,"Product")
      @application = department_totals(@key_projects.project,"Applications")


      #Get Department Totals - Actuals
      @layout_actuals = department_actual_totals(@key_projects.project,"Layout")
      @design_actuals = department_actual_totals(@key_projects.project,"Design")
      @pe_actuals = department_actual_totals(@key_projects.project,"Product")
      @application_actuals = department_actual_totals(@key_projects.project,"Applications")


      #Determine maximum count on actuals for chart width
      actuals_month_count = 12


      #Prepare GoogleCharts data
      @chart_title = "Memory BU Resource Forecast for " + @key_projects.project

      @data = mda(actuals_month_count + 16,6)
      @data[0][0] = 'Month'
      @data[0][1] = 'Layout'
      @data[0][2] = 'Design'
      @data[0][3] = 'PE-TE'
      @data[0][4] = 'Applications'
      @data[0][5] = 'DR1 baseline'

      #load_forecast_to_array(@layout,1)
      #load_forecast_to_array(@design,2)
      #load_forecast_to_array(@pe,3)
      #load_forecast_to_array(@application,4)
      1.upto(15){
        |m|
        @data[actuals_month_count + m][0] = @today.months_since(m-1).month.to_s + '-' + (@today.months_since(m-1).year-2000).to_s
        @data[actuals_month_count + m][1] = (@layout[m-1]*100).round / 100.0
        @data[actuals_month_count + m][2] = (@design[m-1]*100).round / 100.0
        @data[actuals_month_count + m][3] = (@pe[m-1]*100).round / 100.0
        @data[actuals_month_count + m][4] = (@application[m-1]*100).round / 100.0
      }
      1.upto(actuals_month_count){
        |m|
        offset = actuals_month_count + 1 - m
        @data[m][0] = @today.months_ago(offset).month.to_s + '-' + (@today.months_ago(offset).year-2000).to_s
        @data[m][1] = (@layout_actuals[m-1]*100).round / 100.0
        @data[m][2] = (@design_actuals[m-1]*100).round / 100.0
        @data[m][3] = (@pe_actuals[m-1]*100).round / 100.0
        @data[m][4] = (@application_actuals[m-1]*100).round / 100.0
        @data[m][5] = 2

      }
      puts @data


      #Get Department Details
      @all_details = Resource.project_detail_name(@today.at_beginning_of_month,@key_projects.project)
    end
  end
  def load_forecast_to_array(department, index)
    m=1
    department.each do |d|
      @data[actuals_month_count + m][index] = (d[m-1]*100).round / 100.0
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
  def department_actual_totals(project,department)
    #Department Totals
    @date = @today
    dept_totals = Array.new(36,0)
    @date_start = @date.at_beginning_of_month

    total = Resource.department_actual_total(@date_start,project, department)
    puts department
    puts total
    unless total.empty?
      0.upto(2){
        |x|
        dept_totals[x] = total[x].actual unless  total[x].actual.nil?
      }
    end
    dept_totals
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
    #Resource.delete_all
    @removal_date = @today.months_ago(3).beginning_of_month
    Resource.remove_forecast(@removal_date)
    arr_of_arrs = CSV.read(import_file)
    arr_of_arrs.each do |x|
      stack_data(x) if header == 1
      header = 1 if header == 0
    end
  end
  #no longer needed as projects are in the database

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

  def graph
    @chart_title = "Memory BU Resource Forecast for 2012"
    @data = [
      ['Month', 'Design', 'Layout', 'Product', 'Applications', 'Average'],
      ['2012/05', 165, 938, 522, 998, 614.6],
      ['2012/06', 135, 1120, 599, 1268, 682],
      ['2012/07', 157, 1167, 587, 807, 623],
      ['2012/08', 139, 1110, 615, 968, 609.4],
      ['2012/05', 165, 938, 522, 998, 614.6],
      ['2012/06', 135, 1120, 599, 1268, 682],
      ['2012/07', 157, 1167, 587, 807, 623],
      ['2012/08', 139, 1110, 615, 968, 609.4],
      ['2012/05', 165, 938, 522, 998, 614.6],
      ['2012/06', 135, 1120, 599, 1268, 682],
      ['2012/07', 157, 1167, 587, 807, 623],
      ['2012/08', 139, 1110, 615, 968, 609.4],
      ['2012/05', 165, 938, 522, 998, 614.6],
      ['2012/06', 135, 1120, 599, 1268, 682],
      ['2012/07', 157, 1167, 587, 807, 623],
      ['2012/08', 139, 1110, 615, 968, 609.4],
      ['2012/09', 136, 691, 629, 1026, 569.6]
    ]

    #pc = GoogleChart::PieChart.new("400x400", "Food and Drinks Consumed Christmas 2007")
    #pc.data "Laney", 10, '00AF33'
    #pc.data "Christmas Ham", 20, '4BB74C'
    #pc.data "Milk (not including egg nog)",	8, 'EE2C2C'
    #pc.data "Cookies", 25, 'CC3232'
    #pc.data "Roasted Chestnuts", 5, '33FF33'
    #pc.data "Chocolate", 3, '66FF66'
    #pc.data "Various Other Beverages", 15, '9AFF9A'
    #pc.data "Various Other Foods", 9, 'C1FFC1'
    #pc.data "Snacks",	5, 'CCFFCC'
    #@link = pc.to_url

    #GoogleChart::BarChart.new('800x200', 'My Chart', :vertical) do |bc|
    #bc.data 'Design', [5,4,3,1,3,5], '0000ff'
    #bc.data 'PE-TE', [1,2,3,4,5,6], 'ff0000'
    #bc.data 'Applications', [6,5,4,4,5,6], '00ff00'
    #@link2 = bc.to_url
    #end

  end

  protected

  def set_useful_globals
    @auth = session[:user_auth]
    @user_id=session[:user_id]
    @full_name=session[:user_fullname]
    @today=Date.today.months_ago(1)
    @today.to_s(:long)
  end
  # ========================================
  # = mda - make a multi-dimensional array =
  # ========================================
  def mda(width,height)
    a = Array.new(width)
    a.map! { Array.new(height,0) }
    return a
  end
end
