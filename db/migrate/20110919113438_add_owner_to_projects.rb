class AddOwnerToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :owner, :string
  end

  def self.down
     remove_column :projects, :owner    
  end
end
