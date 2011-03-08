class RenameColumnsInTasks < ActiveRecord::Migration
  def self.up
    rename_column :tasks, :assignee, :assignee_id
    rename_column :tasks, :requester, :requester_id
  end

  def self.down
    rename_column :tasks, :requester_id, :requester
    rename_column :tasks, :assignee_id, :assignee
  end
end