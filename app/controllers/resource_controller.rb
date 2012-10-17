class ResourceController < ApplicationController
  require "csv"
  require 'google_chart'
  #require 'finance'

  before_filter :set_useful_globals

  def index
    #Work through projects
    @key_projects = Project.k_proj(@today)
    #@project="SinbadEE"
    #@project_totals = project_totals(@project)
  end

  def availability
    @key = Resource.forward_look_key(@today)
    @others = Resource.forward_look_other(@today)
  end


  def rule_check
    @projects = Project.not_k_proj(@today)
    @overbooked_forecast = Resource.overbooked
    @team_names = Resource.team_names
    #@underbooked_forecast = Resource.overbooked
  end
  #Key Project Index
  def key_projects
    @key_projects = Project.k_proj(@today)
    key_projects_total_hours = Resource.total_forecast_man_hours(@today)
    @kp_total = key_projects_total_hours[0].forecast
  end

  def key_project_summary_new
    if params[:p_id]
      p=params[:p_id].to_i
      @project = Project.find(p)
      #Get Project Start Month (earliest date to graph)
      @first = Resource.project_first(@project.project)

      #Get project end month (last forecast date to graph)
      @last = Resource.project_last(@project.project)

      #Calculate project duration
      @duration = (@last.year*12 + @last.month) - (@first.year * 12 + @first.month) +1

      #Create empty array
      @chart_data = mda(@duration,7)

      #Get actuals data by department
      #Load actuals into array

      #Get forecast data by department
      #Load forecast into array




      @project_totals = Resource.project_total(@today,@project.project)
      @quarterly_rollup = Hash.new(0)
      @project_totals.each do |q|
        hash_tag = q.date.year.to_s
        hash_tag += "-" + ((q.date.month/4)+1).to_s
        puts "Date: #{hash_tag} - MM #{q.forecast}"
        @quarterly_rollup[hash_tag] += (q.forecast)
      end

      @project_totals_actuals = Resource.project_total_actuals(@today,@project.project)
      @quarterly_rollup_actuals = Hash.new(0)
      @project_totals_actuals.each do |q|
        hash_tag = q.date.year.to_s
        hash_tag += "-" + ((q.date.month/4)+1).to_s
        puts "Date: #{hash_tag} - MM #{q.actual}"
        @quarterly_rollup_actuals[hash_tag] += (q.actual)
      end

      @department_totals = Resource.project_department_total(@today, @project.project)


    end
    #
  end

  def phuong
    #@npi_actuals = Finance.new
    #@npi_forecast = Finance.new
    
    #@base_year = Date.new( 2011, 1, 1)
    @actuals = Resource.all_actuals
    @npi_actuals_quarerly = group_actuals_by_quarter( @actuals)
    #@npi_forecast_quarerly = Finance.new

  end


  #Key Project Summary
  def key_project_summary
    if params[:p_id]
      p=params[:p_id].to_i
      @key_projects = Project.find(p)
      project_name = @key_projects.project
      project_name_long = @key_projects.long_name
      @dr_month = find_dr_offset(@key_projects)
      @project_totals = project_totals(@key_projects.project)
      @date = @today
      puts @date
      #Get Department Totals - Forecast
      layout = Resource.department_total_include(@date, project_name,["3101","1370","1390"],"layout")
      @layout = department_totals2(layout)

      design = Resource.department_total_not_include(@date, project_name,["3101","1370","1390"],"layout")
      @design = department_totals2(design)

      pe = Resource.department_total_not_include(@date, project_name,["3371","1340"],"test")
      @pe = department_totals2(pe)
      
      te = Resource.department_total_include(@date, project_name,["3371","1340"],"test")
      @te = department_totals2(te)

      @application = department_totals(project_name,"3209")

      #Get Department Totals - Actuals
      @layout_actuals = get_department_actuals(@date, project_name,["3101","1370","1390"],"layout","include")
      @design_actuals = get_department_actuals(@date, project_name, [ "3101", "1370", "1390"], "layout", "exclude")
      @pe_actuals = get_department_actuals(@date, project_name,["3371","1340"],"test","exclude")
      @te_actuals = get_department_actuals(@date, project_name,["3371","1340"],"test","include")
      @application_actuals = get_department_actuals(@date, project_name, "3209", "void", "exclude")
      
      #Determine maximum count on actuals for chart width
      actuals_month_count = 3


      #Prepare GoogleCharts data
      @chart_title = "Memory BU Resource Forecast for " + project_name_long + ": " + project_name

      @data = mda(actuals_month_count + 16,7)
      @data[0][0] = 'Month'
      @data[0][1] = 'Layout'
      @data[0][2] = 'Design'
      @data[0][3] = 'PE'
      @data[0][4] = 'TE'
      @data[0][5] = 'Applications'
      @data[0][6] = 'DR1 baseline'

      #load_forecast_to_array(@layout,1)
      #load_forecast_to_array(@design,2)
      #load_forecast_to_array(@pe,3)
      #load_forecast_to_array(@application,4)

      #horrible coding!!!
      dr5_month = @key_projects.dr5.month.to_s
      dr5_year = @key_projects.dr5.year.to_s
      dr4_month = @key_projects.dr4.month.to_s
      dr4_year = @key_projects.dr4.year.to_s
      dr3_month = @key_projects.dr3.month.to_s
      dr3_year = @key_projects.dr3.year.to_s
      dr2_month = @key_projects.dr2.month.to_s
      dr2_year = @key_projects.dr2.year.to_s
      dr1_month = @key_projects.dr1.month.to_s
      dr1_year = @key_projects.dr1.year.to_s

      1.upto(15){
        |m|
        month = @today.months_since(m-1).month.to_s
        year = (@today.months_since(m-1).year - 2000 ).to_s
        x_string = month + '-' + year
        year = (@today.months_since(m-1).year).to_s
        
        x_string = "DR5" if ((dr5_month == month) && (dr5_year == year))
        x_string = "DR4" if ((dr4_month == month) && (dr4_year == year))
        x_string = "DR3" if ((dr3_month == month) && (dr3_year == year))
        x_string = "DR2" if ((dr2_month == month) && (dr2_year == year))
        x_string = "DR1" if ((dr1_month == month) && (dr1_year == year))
      
        @data[actuals_month_count + m][0] = x_string
        @data[actuals_month_count + m][1] = (@layout[m-1]*100).round / 100.0
        @data[actuals_month_count + m][2] = (@design[m-1]*100).round / 100.0
        @data[actuals_month_count + m][3] = (@pe[m-1]*100).round / 100.0
        @data[actuals_month_count + m][4] = (@te[m-1]*100).round / 100.0
        @data[actuals_month_count + m][5] = (@application[m-1]*100).round / 100.0
      }
      1.upto(actuals_month_count){
        |m|
        offset = actuals_month_count + 1 - m

        month = @today.months_ago(offset).month.to_s
        year = (@today.months_ago(offset).year-2000 ).to_s
        x_string = month + '-' + year
        year = (@today.months_ago(offset).year ).to_s

        x_string = "DR5" if ((dr5_month == month) && (dr5_year == year))
        x_string = "DR4" if ((dr4_month == month) && (dr4_year == year))
        x_string = "DR3" if ((dr3_month == month) && (dr3_year == year))
        x_string = "DR2" if ((dr2_month == month) && (dr2_year == year))
        x_string = "DR1" if ((dr1_month == month) && (dr1_year == year))

        @data[m][0] = x_string
        @data[m][1] = (@layout_actuals[m-1]*100).round / 100.0
        @data[m][2] = (@design_actuals[m-1]*100).round / 100.0
        @data[m][3] = (@pe_actuals[m-1]*100).round / 100.0
        @data[m][4] = (@te_actuals[m-1]*100).round / 100.0
        @data[m][5] = (@application_actuals[m-1]*100).round / 100.0
        #@data[m][5] = 2

      }


      #puts @data


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
        unless total[x].nil?
          project_totals[x] = total[x].forecast
          project_totals[15] += total[x].forecast
        end
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
  def department_totals2(data)
    #Department Totals
    dept_totals = Array.new(17,0)
    unless data[0].nil?
      0.upto(14){
        |x|
        unless data[x].forecast.blank?
          dept_totals[x] = data[x].forecast
        end
        dept_totals[15] += data[x].forecast  if  data[x].forecast
      }
    end
    dept_totals[16] = dept_totals[15]/12
    dept_totals
  end
  def department_actual_totals2(data)
    #Department Totals
    dept_totals = Array.new(17,0)
    #count = data.count
    #puts count
    #total = Resource.department_total(@date_start,project, department)
    #unless count < 15
    unless data[0].nil?
      0.upto(2){
        |x|
        puts 'James '+x.to_s
        unless data[x].actual.blank?
          dept_totals[x] = data[x].actual
        end
        #dept_totals[15] += data[x].actual  if  data[x].actual
      }
    end

    dept_totals[16] = dept_totals[15]/12
    #end
    dept_totals
    #end
  end
  def get_department_actuals( date,project, department, team, filter)
    a = Resource.department_total_actual_include(date, project, department, team) if filter == "include"
    a = Resource.department_total_actual_not_include(date, project, department, team) if filter == "exclude"
    department_actual_totals2(a)
  end
  #
  #
  #
  def import
    #initial variables
    header = 0
    #filenames
    import_file = "import/2012q3.csv"
    puts
    puts "============================================="
    puts "CSV importer for Resource Allocation database"
    puts "Resource List Import tool"
    puts "============================================="
    #import and stack data
    #delete database
    Resource.delete_all
    @removal_date = @today.months_ago(3).beginning_of_month
    Resource.remove_forecast(@removal_date)
    arr_of_arrs = CSV.read(import_file)
    arr_of_arrs.each do |x|
      #puts x
      stack_data(x) if header == 1
      header = 1 if header == 0
    end
  end
  #no longer needed as projects are in the database

  #
  def stack_data(line)
    #puts "==="
    #puts line[4]
    #puts "==="
    unless line[4].nil?
      line[4].rstrip!
      write_record(line)
      update_record(line)
    end
  end
  #
  #
  #
  def write_record(record)
    puts record
    #write new record to database
    date_start = @today.at_beginning_of_month - 3.months
    9.upto(26){
      |x|
      #work through forecast data
      if x < 6
        #+print+ ":Actual   "
      else
        #print ":Forecast "
        date_current=date_start.months_since(x-9)
        if record[x].nil?
          record[x]=0
        end
        new_to_db(date_current,record[0],record[1], record[3],record[4],record[5],record[x])
      end
    }
  end

  def update_record  (record)
    date_start = @today.at_beginning_of_month - 3.months
    0.upto(2){
      |m|
      date_current=date_start.months_since(m)
      find_record_enter_actual(date_current,record[0], record[3],record[4],record[5],record[m+6])
    }
  end

  #Write the project.csv file to the project.db
  #def write_project_record(record)
  # new_to_project_db(record[0], record[1],record[2],record[3],record[4],record[5],record[6],record[7])
  #end
  #
  #
  #
  def new_to_db(date, dept, team, name, project, function, time)
    record = Resource.new
    if time.nil?
      time = 0
    end
    record.date = date
    record.name = name
    record.department = dept
    record.team = team.downcase
    record.project = project
    record.function = function
    record.actual = 0
    record.forecast = time
    record.save
  end
  def find_record_enter_actual(date,dept,name,project,function,time)
    record = Resource.update_actual(date,dept,name,project,function)
    #puts record.count
    #puts record.id
    #puts record.name
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
# ====Finance stuff =====
def group_actuals_by_quarter( dataset)
  quarter_data = Hash.new(0)
  dataset.each do |d|
    hash_tag = d.project + ", "
    hash_tag += d.department + ", "
    hash_tag += d.date.year.to_s
    hash_tag += "-" + ((d.date.month/4)+1).to_s
    quarter_data[hash_tag] += d.actual
    puts hash_tag
  end  
  quarter_data
end


  protected

  def set_useful_globals
    @auth = session[:user_auth]
    @user_id=session[:user_id]
    @full_name=session[:user_fullname]
    now = Date.today.beginning_of_month
    now_month = (now.month) - 1
    now_offset = now_month.modulo(3)
    @today=now.months_ago(now_offset)
    @today.to_s(:long)
    #@today.beginning_of_month
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
