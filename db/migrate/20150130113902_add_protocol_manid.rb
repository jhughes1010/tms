class AddProtocolManid < ActiveRecord::Migration
  def self.up
    add_column :manids, :protocol, :string
    remove_column :manids, :keyid 
  end

  def self.down
    remove_column :manids, :protocol
    add_column :manids, :keyid, :string
  end
end
