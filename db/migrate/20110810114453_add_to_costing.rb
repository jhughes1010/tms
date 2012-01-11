class AddToCosting < ActiveRecord::Migration
  def self.up
    add_column :costings, :pc, :string
    add_column :costings, :rfwafer, :string
    add_column :costings, :wafer, :string
    add_column :costings, :probemat, :string
    add_column :costings, :plant, :string
    add_column :costings, :pohgroup, :string
    add_column :costings, :asmmat, :string
    add_column :costings, :asmohgroup, :string
    add_column :costings, :asminforec, :string
    add_column :costings, :tsmat, :string
    add_column :costings, :tsohgroup, :string
    add_column :costings, :tstinforec, :string
    add_column :costings, :fginforec, :string
    add_column :costings, :rwcost, :float
    add_column :costings, :wafercost, :float
    add_column :costings, :pcostwafer, :float
    add_column :costings, :grossdie, :integer
    add_column :costings, :sortyield, :float
    add_column :costings, :netgooddie, :integer
    add_column :costings, :probe_time, :float
    add_column :costings, :probe_overhead, :float
    add_column :costings, :diecost, :float
    add_column :costings, :asm_ohcost, :float
    add_column :costings, :asm_subcon, :float
    add_column :costings, :asm_yield, :float
    add_column :costings, :asm_cost, :float
    add_column :costings, :tst_ohcost, :float
    add_column :costings, :tst_subcon, :float
    add_column :costings, :tst_yield, :float
    add_column :costings, :tst_cost, :float
    add_column :costings, :fg_subcon, :float
    add_column :costings, :fg_yield, :float
    add_column :costings, :fg_stdcost, :float
    
  end

  def self.down
    
    remove_column :costings, :pc
    remove_column :costings, :rfwafer
    remove_column :costings, :wafer
    remove_column :costings, :probemat
    remove_column :costings, :plant
    remove_column :costings, :pohgroup
    remove_column :costings, :asmmat
    remove_column :costings, :asmohgroup
    remove_column :costings, :asminforec
    remove_column :costings, :tsmat
    remove_column :costings, :tsohgroup
    remove_column :costings, :tstinforec
    remove_column :costings, :fginforec
    remove_column :costings, :rwcost
    remove_column :costings, :wafercost
    remove_column :costings, :pcostwafer
    remove_column :costings, :grossdie
    remove_column :costings, :sortyield
    remove_column :costings, :netgooddie
    remove_column :costings, :probe_time
    remove_column :costings, :probe_overhead
    remove_column :costings, :diecost
    remove_column :costings, :asm_ohcost
    remove_column :costings, :asm_subcon
    remove_column :costings, :asm_yield
    remove_column :costings, :asm_cost
    remove_column :costings, :tst_ohcost
    remove_column :costings, :tst_subcon
    remove_column :costings, :tst_yield
    remove_column :costings, :tst_cost
    remove_column :costings, :fg_subcon
    remove_column :costings, :fg_yield
    remove_column :costings, :fg_stdcost
  end
end
