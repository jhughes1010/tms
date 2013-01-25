class ImportController < ApplicationController

  require "csv"
  def clear
    Costing.delete_all
  end

  def npi
    #initial variables
    header = 0
    #filenames
    import_file = "import/2012Q4_KeyProjects.csv"
    puts
    puts "============================================="
    puts "CSV importer for Costing database"
    puts "Costing List Import tool"
    puts "============================================="
    puts import_file
    Project.delete_all
    arr_of_arrs = CSV.read(import_file)
    arr_of_arrs.each do |x|
      write_csv_data(x) if header >=1
      header += 1
    end
  end

  def write_csv_data(record)
    if record[5] == "Current Plan"
      puts record
      column_array= [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
      new_to_costing_db(record, column_array)
    end
  end

  def new_to_costing_db(record, column_array)
    #create new record and write data fields
    r = Project.new
    r.key = true
    r.project = record[column_array[3]]
    r.long_name = record[column_array[0]]
    r.dr1 = format_date(record[column_array[10]])
    r.dr2 = format_date(record[column_array[11]])
    r.dr3 = format_date(record[column_array[12]])
    r.dr4 = format_date(record[column_array[13]])
    r.dr5 = format_date(record[column_array[14]])

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
    unless date.nil?
      date = Date.strptime(date, "%m/%d/%Y")
    end
    if date.nil?
      date = Date.today.next_year(10)
    end
    puts "Imported Date:" + date.to_s
    date
  end
  def setup
    #initial variables
    header = 0
    #filenames
    import_file = "import/pv_acp.txt"
    puts
    puts "============================================="
    puts "CSV importer for ProberVision_setup.txt database"
    puts "setup.txt List Import tool"
    puts "============================================="
    puts import_file
    Setup.delete_all
    arr_of_arrs = IO.readlines(import_file)
    arr_of_arrs.each do |x|
      y = x.split
      write_csv_data_setup(y) if header >=1
      header += 1
    end
  end
  def write_csv_data_setup(record)
    temp = record[0].split('_')
    puts temp[0].class
    unless temp[0].nil?
      puts temp[0]
    end
    #puts temp[1] unless temp[1].nil?
    if record[0] == "Current Plan"
      puts record[0]
      column_array= [0,1,2,3,4,5]
      #new_to_costing_db(record, column_array)
    end
  end
end
