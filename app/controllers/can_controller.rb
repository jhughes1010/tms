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
    CanMain.delete_all
    arr_of_arrs = CSV.read(import_file)
    arr_of_arrs.each do |x|
      puts x
      write_csv_data(x) if header == 1
      header = 1 if header == 0
    end
  end

  def write_csv_data(record)
    column_array= [1,16,15,14,13,12,11,4,5,6,7,8,9,10]
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
    r = CanMain.new
    r.can = record[column_array[0]]
    r.internal = record[column_array[7]]
    r.sort = record[column_array[8]]
    r.mark = record[column_array[9]]
    r.ft = record[column_array[10]]
    r.assy_loc = record[column_array[11]]
    r.device_tab = record[column_array[12]]
    r.inactive = record[column_array[7]]
    r.customer = record[column_array[6]]
    r.interface = record[column_array[5]]
    r.mfg_id = record[column_array[4]]
    r.i2w_addr = record[column_array[3]]
    r.comments = record[column_array[2]]
    r.fw_version = record[column_array[1]]
    r.save
  end
end
