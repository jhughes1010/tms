class CreateTaskLogs < ActiveRecord::Migration
  def self.up
    create_table :task_logs do |t|
      t.text :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :task_logs
  end
end
