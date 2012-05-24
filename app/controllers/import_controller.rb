class ImportController < ApplicationController

    require "csv"
    def clear
      Costing.delete_all
    end

    def npi
      #initial variables
      header = 0
      #filenames
      import_file = "import/2012Q1_KeyProjects.csv"
      puts
      puts "============================================="
      puts "CSV importer for Costing database"
      puts "Costing List Import tool"
      puts "============================================="
      Project.delete_all
      arr_of_arrs = CSV.read(import_file)
      arr_of_arrs.each do |x|
        write_csv_data(x) if header >=1
        header += 1
      end
    end

    def write_csv_data(record)
      if record[3] == "Current Plan"
        puts record
      column_array= [0,1,2,3,4,5,6,7,8,9,10,11]
      new_to_costing_db(record, column_array)
    end
    end

    def new_to_costing_db(record, column_array)
      #create new record and write data fields
      r = Project.new
      r.key = true
      r.project = record[column_array[2]]
      r.long_name = record[column_array[0]]
      r.dr1 = format_date(record[column_array[7]])
      r.dr2 = format_date(record[column_array[8]])
      r.dr3 = format_date(record[column_array[9]])
      r.dr4 = format_date(record[column_array[10]])
      r.dr5 = format_date(record[column_array[11]])
      
      if record[column_array[0]]["_SE_"]
        r.owner = "Serial"
      elsif 
        record[column_array[0]]["_CP_"]
        r.owner = "Crypto"
      elsif 
        record[column_array[0]]["_DF_"]
        r.owner = "DataFlash"
      elsif 
        record[column_array[0]]["_BF_"]
        r.owner = "BIOSFlash"
      elsif 
        record[column_array[0]]["_AP_"]
        r.owner = "Analog"
      end
      r.save
    end
    def format_date(date)
      #puts "Imported Date:" + date
      unless date.nil?
        date = Date.strptime(date, "%m/%d/%Y")
      end
      date
    end
end
