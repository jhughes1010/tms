class CreateTestTimes < ActiveRecord::Migration
  def self.up
    create_table :test_times do |t|
      t.integer :device_id
      t.string :paralllelism
      t.integer :time
      t.string :operation
      t.date :date

      t.timestamps
    end
  end

  def self.down
    drop_table :test_times
  end
end
