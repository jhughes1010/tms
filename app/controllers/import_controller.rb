class ImportController < ApplicationController

  require "csv"

  def setup
    puts
    puts "============================================="
    puts "CSV importer for ProberVision_setup.txt database"
    puts "setup.txt List Import tool"
    puts "============================================="
    Setup.delete_all
    import_setup("ACP","import/pv_acp.txt")
    import_setup("MEMP","import/pv_memp.txt")
    UserMailer.setup_import_complete(['james.hughes@atmel.com','mark.chabica@atmel.com']).deliver
  end
  def import_setup(location, path)
    puts location
    device_list = Device.get_family(["2W","3W","SPI","CP","TS"])
    list = device_list.map {|i| i.name }
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
              record[10].upcase! unless record[10].nil?
              record[11].upcase! unless record[11].nil?
              record[12].upcase! unless record[12].nil?
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
    puts "Device List Import tool"
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
  end
  def cp_time
    puts
    puts "============================================="
    puts "Text file importer for time.rpt"
    puts "Device CPx Import tool"
    puts "============================================="

    #Get all devices
    @devices = Device.all
    @devices.each do |d|
      #call function to itterate through time.rpt files for each device
      getDeviceFromTimeRpt(d)
    end
  end
  def getDeviceFromTimeRpt(device)
    #search time.rpt(s) for device entries and add to database
    
  end
end
