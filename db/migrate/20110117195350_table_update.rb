class TableUpdate < ActiveRecord::Migration
  def self.up
    add_column :tasks, :accepted, :boolean 
    add_column :tasks, :device, :integer
    add_column :tasks, :platform, :string
  end
  
  def self.down
    remove_column :tasks, :accepted
    remove_column :tasks, :device
    remove_column :tasks, :platform
  end
end
