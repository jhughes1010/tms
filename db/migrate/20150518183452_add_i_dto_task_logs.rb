class AddIDtoTaskLogs < ActiveRecord::Migration
  def self.up
    add_column :task_logs, :task_id, :integer
  end

  def self.down
    remove_column :task_logs, :task_id
  end
end
