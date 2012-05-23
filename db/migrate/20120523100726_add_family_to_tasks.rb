class AddFamilyToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :family, :string
  end

  def self.down
    remove_column :tasks, :family
  end
end
