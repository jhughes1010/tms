class AddTaskColumn < ActiveRecord::Migration
  def self.up
    add_column :tasks, :complete, :boolean
    add_column :tasks, :tcd, :date
    add_column :tasks, :description, :text
    add_column :tasks, :operation, :string    
  end

  def self.down
    remove_column :tasks, :complete
    remove_column :tasks, :tcd
    remove_column :tasks, :description
    remove_column :tasks, :operation     
  end
end
