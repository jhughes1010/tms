class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.integer :requester
      t.integer :assignee
      t.string :taskname
      t.date :scd
      t.date :acd
      t.integer :priority
      t.integer :type

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
