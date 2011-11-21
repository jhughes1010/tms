class CostController < ApplicationController
  require "csv"
  def clear
    Costing.delete_all
  end

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
    Costing.delete_all
    arr_of_arrs = CSV.read(import_file)
    arr_of_arrs.each do |x|
      write_csv_data(x) if header == 1
      header = 1 if header == 0
    end
  end

  def write_csv_data(record)
    column_array= [2,4,7,10,18,19,21,24,26,28,34,36,38,47,51,56,57,58,59,60,61,62,63,65,66,67,70,72,73,74,77,80,81,84]
    new_to_costing_db(record, column_array)
  end

  def new_to_costing_db(record, column_array)
    #create new record and write data fields
    r = Costing.new
    r.device = record[column_array[0]]
    r.pc = record[column_array[1]]
    r.rfwafer = record[column_array[2]]
    r.wafer = record[column_array[3]]
    r.probemat = record[column_array[4]]
    r.plant = record[column_array[5]]
    r.pohgroup = record[column_array[6]]
    r.asmmat = record[column_array[7]]
    r.asmohgroup = record[column_array[8]]
    r.asminforec = record[column_array[9]]
    r.tsmat = record[column_array[10]]
    r.tsohgroup = record[column_array[11]]
    r.tstinforec = record[column_array[12]]
    r.fginforec = record[column_array[13]]
    r.rwcost = record[column_array[14]]
    r.wafercost =  record[column_array[15]]
    r.pcostwafer = record[column_array[16]]
    r.grossdie = record[column_array[17]]
    r.sortyield = record[column_array[18]]
    r.netgooddie = record[column_array[19]]
    r.probe_time = record[column_array[20]]
    r.probe_overhead = record[column_array[21]]
    r.diecost = record[column_array[22]]
    r.asm_ohcost = record[column_array[23]]
    r.asm_subcon = record[column_array[24]]
    r.asm_yield = record[column_array[25]]
    r.asm_cost = record[column_array[26]]
    r.tst_ohcost = record[column_array[27]]
    r.tst_subcon = record[column_array[28]]
    r.tst_yield = record[column_array[29]]
    r.tst_cost = record[column_array[30]]
    r.fg_subcon = record[column_array[31]]
    r.fg_yield = record[column_array[32]]
    r.fg_stdcost = record[column_array[33]]
    r.save
  end
  # Web report output
  # result/1/
  def result
    @cost = Costing.find(params[:id])
  end
  def query
    @cost = Costing.search(params)
  end
end
