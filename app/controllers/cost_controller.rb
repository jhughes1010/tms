class CostController < ApplicationController
  require "csv"
  def import
    #initial variables
    header = 0
    #filenames
    import_file = "import/costing.csv"
    puts
    puts "============================================="
    puts "CSV importer for Costing database"
    puts "Costing List Import tool"
    puts "============================================="
    #import and stack data
    #delete database
    Resource.delete_all
    arr_of_arrs = CSV.read(import_file)
    arr_of_arrs.each do |x|
      write_csv_data(x) if header == 1
      header = 1 if header == 0
  end
end

def write_csv_data(record)
  #new_to_costing_db(record[0], record[1],record[2],record[3],record[4],record[5],record[6],record[7])
  record.each do |x|
    print x
    print "--"
  end
    puts
    puts "--- New Record ---"
end
#
#
#
def new_to_costing_db(date,dept,name,overbook,project,function,time)
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


end
