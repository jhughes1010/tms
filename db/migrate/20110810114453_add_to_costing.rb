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
    add_column :costings, :probetime, :float
    add_column :costings, :probeoverhead, :float
    add_column :costings, :diecost, :float
    add_column :costings, :asmohcost, :float
    add_column :costings, :asmsubcon, :float
    add_column :costings, :asmyield, :float
    add_column :costings, :asmcost, :float
    add_column :costings, :tstohcost, :float
    add_column :costings, :tstsubcon, :float
    add_column :costings, :tstyield, :float
    add_column :costings, :tstcost, :float
    add_column :costings, :fgsubcon, :float
    add_column :costings, :fgyield, :float
    add_column :costings, :fgstdcost, :float
    
  end

  def self.down
  end
end
