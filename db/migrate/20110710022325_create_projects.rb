class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :project
      t.boolean :key
      t.date :tapeout
      t.date :dr1
      t.date :dr2
      t.date :dr3
      t.date :dr4
      t.date :dr5

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
