class ImportController < ApplicationController

    require "csv"
    def clear
      Costing.delete_all
    end

    def npi
      #initial variables
      header = 0
      #filenames
      import_file = "import/2011Q4_KeyProjects.csv"
      puts
      puts "============================================="
      puts "CSV importer for Costing database"
      puts "Costing List Import tool"
      puts "============================================="
      Project.delete_all
      arr_of_arrs = CSV.read(import_file)
      arr_of_arrs.each do |x|
        write_csv_data(x) if header >=8
        header += 1
      end
    end

    def write_csv_data(record)
      unless record[3] == "Baseline Plan"
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
      r.dr1 = record[column_array[7]]
      puts record[column_array[7]]
      r.dr2 = record[column_array[8]]
      r.dr3 = record[column_array[9]]
      r.dr4 = record[column_array[10]]
      r.dr5 = record[column_array[11]]
      r.save
    end

end
