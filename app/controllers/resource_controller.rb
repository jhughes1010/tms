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
    record=line.split(",")
    print_record(record)
    #columns 5-7,11-25 need data stacking with individual record edits or create as necessary
    update_record(record)
  end
  def print_record(record)
    print "Record:" 
    for f in record
      print f + " "
    end
    puts
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

