class ImportController < ApplicationController

  require "csv"
  def clear
    Costing.delete_all
  end

  def npi
    #initial variables
    header = 0
    #filenames
    import_file = "import/2013Q2_KeyProjects.csv"
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
    r.dr1 = format_date(record[column_array[9]])
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
    puts
    puts "============================================="
    puts "CSV importer for ProberVision_setup.txt database"
    puts "setup.txt List Import tool"
    puts "============================================="
    Setup.delete_all
    import_setup("ACP","import/pv_acp.txt")
    import_setup("MEMP","import/pv_memp.txt")
  end
  def import_setup(location, path)
    puts location
    # device_list = Device.get_family(["2w","3W","SPI","CP","TS"])
    device_list = Device.get_family(["2w","3W","SPI"])
    list = device_list.map {|i| i.name }
    puts list
    # #
    # wire2 = Device.get_family("2W")
    # list = wire2.map {|i| i.name }
    # #
    # wire3 = Device.get_family("3W")
    # list2 = wire3.map {|i| i.name }
    # #
    # spi = Device.get_family("SPI")
    # list3 = spi.map {|i| i.name }
    # #
    # cp = Device.get_family("CP")
    # list4 = cp.map {|i| i.name }
    # #
    # ts = Device.get_family("TS")
    # list5 = ts.map {|i| i.name }
    # #
    # list = list.concat(list2)
    # list = list.concat(list3)
    # list = list.concat(list4)
    # list = list.concat(list5)
    file = IO.readlines( path )
    header = 0
    file.each do |f|
      write_csv_data_setup( f, location, list ) if header == 1
      header = 1
    end
  end
  def write_csv_data_setup(line, location, list )
    #Split line into individual components
    record = line.split()
    unless record.nil?
      unless record[0].nil?
        device = record[0].split('_')
        unless device[0].include? "---"
          unless device[0].include? "***"
            if list.include?(device[0])
              #puts "#{location}:#{device[0]} #{device[1]} #{record[2]} #{record[10]} #{record[11]} #{record[12]} "
              #write record
              r = Setup.new
              d = Device.find_by_name(device[0])
              r.family = d.productline
              r.location = location
              r.device = device[0]
              r.tab = device[1]
              r.platform = record[2]
                if record[2].start_with?("HD")
                  r.vendor ="MAG"
                elsif record[2].include?("EPRO")
                  r.vendor ="EPRO"
                else
                  r.vendor ="MAV"
                end
              r.parallelism = record[6].downcase
              #uppercase
              record[10] = record[10].upcase unless record[10].nil?
              record[11] = record[11].upcase unless record[11].nil?
              record[12] = record[12].upcase unless record[12].nil?
              unless record[10].nil?
                record[10] = record[10].split(".ZIP")[0]
                #record[10] = temp[0]
              end
              r.cp1 = record[10]
              unless record[11].nil?
                record[11] = record[11].split(".ZIP")[0]
                record[11] = record[10] if record[11].include? "SAME"
              end
              r.cp2 = record[11]
              unless record[12].nil?
                record[12] = record[12].split(".ZIP")[0]
                record[12] = record[11] if record[12].include? "SAME"
              end
              r.cp3 = record[12]
              r.save
            end
          end
        end

      end
    end
  end
  def device
    puts
    puts "============================================="
    puts "CSV importer for ProberVision_setup.txt database"
    puts "setup.txt List Import tool"
    puts "============================================="
    Device.delete_all
    import_device("2W","import/2wire.txt")
    import_device("3W","import/3wire.txt")
    import_device("SPI","import/spi.txt")
    import_device("CP","import/CP.txt")
    import_device("TS","import/TS.txt")
  end
  def import_device(family, path)
    puts family
    file = IO.readlines( path )
    file.each do |f|
      write_csv_data_device( f, family )
    end
  end
  def write_csv_data_device(line, family )
    #Split line into individual components
    record = line.strip()
    unless record.nil?
      #puts "#{family}:#{record}"
      #write record
      r = Device.new
      r.productline = family
      r.name = record
      r.save
    end
    #end

    #end
    #end
  end
end
