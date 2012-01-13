class ChangeTasks < ActiveRecord::Migration
  def self.up
    change_column :tasks, :device, :string
  end

  def self.down
    change_column :tasks, :device, :integer
  end
end
