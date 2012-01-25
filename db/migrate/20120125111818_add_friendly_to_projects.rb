class AddFriendlyToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :long_name, :string
  end

  def self.down
    remove_column :projects, :long_name 
  end
end
