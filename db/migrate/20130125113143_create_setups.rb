class CreateSetups < ActiveRecord::Migration
  def self.up
    create_table :setups do |t|
      t.string :location
      t.string :family
      t.string :device
      t.string :tab
      t.string :platform
      t.string :cp1
      t.string :cp2
      t.string :cp3

      t.timestamps
    end
  end

  def self.down
    drop_table :setups
  end
end
