  class ResourceController < ApplicationController
      require "fastercsv"
    def index
      #Project Totals
      @project_totals = Array.new(17,0)
      #@group_totals = Array.new(17,0)

      @date = Date.today
      @date_start = @date.at_beginning_of_month
          total = Resource.sapphire(@date_start)
      0.upto(14){
        |x|

      @project_totals[x] = total[x].forecast   
      @project_totals[15] += total[x].forecast  
       }
       @project_totals[16] = @project_totals[15]/12
       #Department Totals


    end
    #
    #
    #
    def import
      #initial variables
      header = 0
      #filenames
      import_file = "import/test_engineering.csv"
      puts
      puts "============================================="
      puts "CSV importer for Resource Allocation database"
      puts "============================================="
      #import and stack data   
      #delete database
      Resource.delete_all
      arr_of_arrs = FasterCSV.read(import_file) 
      arr_of_arrs.each do |x|  
        stack_data(x) if header == 1
        header = 1 if header == 0
      end
    end 
    #
    #
    #
    def stack_data(line)
      #puts line
      #set_nil_to_zero(line)
      write_record(line)
    end
    #
    #
    #
    def write_record(record)
      #write new record to database
      4.upto(24){
        |x|
        date = Date.today
        date_start = date.at_beginning_of_month - 3.months
        #print date_start
        #print " "
        0.upto(3){
          |y|
          #print record[y] + " " if record[y]
        }
        if x < 7
            #print ":Actual   "
        else
            #print ":Forecast "
            date_current=date_start.months_since(x-4)
         new_to_db(date_current,record[0], record[1],record[2],record[3],record[x])  
              end
        #puts record[x]

      }
    end
    #
    #
    #
    def new_to_db(date,dept,name,project,function,time)
      #print date
      #print " "
      record = Resource.new
      record.date = date
      record.name = name
      record.department = dept
      record.project = project
      record.function = function
      record.actual = 0
      record.forecast = time

      record.save

    end
  end

