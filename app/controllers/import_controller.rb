class ImportController < ApplicationController

  require "csv"

  #entry point for setup.txt import
  def setup
    puts
    puts "============================================="
    puts "CSV importer for ProberVision_setup.txt database"
    puts "setup.txt List Import tool"
    puts "============================================="
    Setup.delete_all
    @ACPmodified = import_setup("ACP","import/pv_acp.txt")
    @MEMPmodified = import_setup("MEMP","import/pv_memp.txt")
    UserMailer.setup_import_complete(['james.hughes@atmel.com','mark.chabica@atmel.com','mike.flanagan@atmel.com','francis.cordier@atmel.com','emmanuel.espinocilla@atmel.com']).deliver
  end
  def device
    puts
    puts "============================================="
    puts "CSV importer for ProberVision_setup.txt database"
    puts "Device List Import tool"
    puts "============================================="
    Device.delete_all
    import_device("2Wire","import/2wire.txt")
    import_device("3Wire","import/3wire.txt")
    import_device("SPI","import/spi.txt")
    import_device("Crypto","import/CP.txt")
    import_device("TS","import/TS.txt")
    #AVR files
    import_device("AVR8","import/AVR8.txt")
    import_device("AVR32","import/AVR32.txt")
    import_device("ARM","import/ARM.txt")
    import_device("C51","import/c51.txt")
    import_device("XMEGA","import/XMEGA.txt")
    import_device("Touch","import/Touch.txt")
    
  end
  protected
  
  def import_setup(location, path)
    puts location
    device_list = Device.get_family(["2Wire","3Wire","SPI","Crypto","TS","AVR8","AVR32","ARM","C51","XMEGA","Touch"])
    list = device_list.map {|i| i.name }
    modified = File.mtime
    file = IO.readlines( path )
    header = 0
    file.each do |f|
      write_csv_data_setup( f, location, list ) if header == 1
      header = 1
    end
    modified
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
  #entry point for device.txt import for each family (2wire.txt, spi,txt, etc)
 
  def import_device(family, path)
    puts family
    file = IO.readlines( path )
    file.each do |f|
      write_csv_data_device( f, family )
    end
  end
  def write_csv_data_device(line, family )
    record = line.strip()
    unless record.nil?
      r = Device.new
      r.productline = family
      r.name = record
      r.save
    end
  end
  #refactored variant
  def write_csv_data_setup_variant(line, location, list )
    #Split line into individual components
    record = line.split()
    if setup_valid(record)
        setup_record_format(record)
        setup_save_record(record)
    end
  end 
  def setup_invalid(record)
    invalid_flag = false
    result_flag = true if record.nil?
    result_flag = true if record[0].nil?
    result_flag = true if device[0].include? "---"
    result_flag = true if device[0].include? "***"
    invalid_flag
  end 
  def setup_record_format(record)
    
  end
  def setup_save_record(record)
    #write record
    r = Setup.new
    d = Device.find_by_name(device[0])
    r.family = d.productline
    r.location = location
    r.device = device[0]
    r.tab = device[1]
    r.platform = record[2]
    r.parallelism = record[6].downcase
    r.cp1 = record[10]
    r.cp2 = record[11]
    r.cp3 = record[12]
    r.save
  end
end
