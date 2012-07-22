class CreateTestProgs < ActiveRecord::Migration
  def self.up
    create_table :test_progs do |t|
      t.string :engineer
      t.string :status
      t.string :prog_name
      t.string :operation
      t.string :date_received
      t.string :comments

      t.timestamps
    end
  end

  def self.down
    drop_table :test_progs
  end
end
