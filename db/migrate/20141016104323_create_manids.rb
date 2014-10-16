class CreateManids < ActiveRecord::Migration
  def self.up
    create_table :manids do |t|
      t.string :device
      t.string :customer
      t.string :products
      t.integer :can_id
      t.string :mfgid
      t.string :keyid

      t.timestamps
    end
  end

  def self.down
    drop_table :manids
  end
end
