class RenameColtoTasks < ActiveRecord::Migration
  def self.up
rename_column :tasks, :type, :request_type
  end

  def self.down
  end
end
