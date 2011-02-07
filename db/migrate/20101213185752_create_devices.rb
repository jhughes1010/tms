class CreateDevices < ActiveRecord::Migration
  def self.up
    create_table :devices do |t|
      t.string :name
      t.string :friendly
      t.integer :gdpw
      t.string :productline

      t.timestamps
    end
  end

  def self.down
    drop_table :devices
  end
end
