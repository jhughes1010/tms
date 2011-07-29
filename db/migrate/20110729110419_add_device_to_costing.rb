class AddDeviceToCosting < ActiveRecord::Migration
  def self.up
    add_column :costings, :device, :string
  end

  def self.down
    remove_column :costings, :device
  end
end
