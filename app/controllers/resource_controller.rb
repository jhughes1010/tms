class ResourceController < ApplicationController
    require "fastercsv"
  def index
  end
  def import
    #initial variables
    header = 0
    #filenames
    import_file = "import/test_engineering.csv"
    #Get forecast data
    #f=File.open(import_file)
    #text = f.readlines
    #f.close
    puts
    puts "============================================="
    puts "CSV importer for Resource Allocation database"
    puts "============================================="
    #import and stack data   
    arr_of_arrs = FasterCSV.read(import_file) 
    arr_of_arrs.each do |x|  
      stack_data(x) if header == 1
      header = 1 if header == 0
    end
  end 
  def stack_data(line)
    puts line
    write_record(line)
  end

  def update_record(record)
    #write new record to database
    4.upto(24){
      |x|
      print Date.today
      0.upto(3){
        |y|
        print record[y] + " "
      }
      puts record[x]
    }
  end
end

