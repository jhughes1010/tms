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
    Costing.delete_all
    arr_of_arrs = CSV.read(import_file)
    arr_of_arrs.each do |x|
      write_csv_data(x) if header == 1
      header = 1 if header == 0
  end
end

def write_csv_data(record)
  column_array= [2,4,7,10,18,21,24,26,28,34,36,38,47,51,56,57,58,59,60,61,62,63,65,66,67,70,72,73,74,77,80,81,84]
  new_to_costing_db(record, column_array)
  #record.each do |x|
    #print x
    #print "--"
  #end
    #puts
    #puts "--- New Record ---"
end
#
#
#
def new_to_costing_db(record, column_array)
  #create new record and write data fields
  r = Costing.new
  r.device = record[column_array[0]]
  #puts record[column_array[0]]
  r.save
end


end
