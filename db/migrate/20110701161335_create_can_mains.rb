class CreateCanMains < ActiveRecord::Migration
  def self.up
    create_table :can_mains do |t|
      t.string :can
      t.boolean :internal
      t.boolean :sort
      t.boolean :mark
      t.boolean :ft
      t.boolean :assy_loc
      t.boolean :device_tab
      t.boolean :inactive
      t.string :customer
      t.string :interface
      t.string :mfg_id
      t.string :i2w_addr
      t.text :comments
      t.string :fw_version

      t.timestamps
    end
  end

  def self.down
    drop_table :can_mains
  end
end
