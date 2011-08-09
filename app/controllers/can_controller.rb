class CanController < ApplicationController
  require "csv"
  def import_main
    #initial variables
    header = 0
    #filenames
    import_file = "import/can.csv"
    puts
    puts "============================================="
    puts "CSV importer for CAN master database"
    puts "CAN List Import tool"
    puts "============================================="
    #import and stack data
    #delete database
    Can_main.delete_all
    arr_of_arrs = CSV.read(import_file)
    arr_of_arrs.each do |x|
      puts x
      #write_csv_data(x) if header == 1
      header = 1 if header == 0
    end
  end

  def write_csv_data(record)
    column_array= [1,3]
    new_to_can_db(record, column_array)
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
  def new_to_can_db(record, column_array)
    #create new record and write data fields
    r = Can_main.new
    r.can = record[column_array[0]]
    r.internal = record[column_array[1]]
    r.sort = record[column_array[2]]
    r.mark = record[column_array[3]]
    r.ft = record[column_array[4]]
    r.assy_loc = record[column_array[5]]
    r.device_tab = record[column_array[6]]
    r.inactive = record[column_array[7]]
    r.customer = record[column_array[8]]
    r.interface = record[column_array[9]]
    r.mfg_id = record[column_array[10]]
    r.i2w_addr = record[column_array[11]]
    r.comments = record[column_array[12]]
    r.fw_version = record[column_array[13]]
    r.save
  end
end
