class CreateTargets < ActiveRecord::Migration
  def self.up
    create_table :targets do |t|
      t.string :family
      t.string :device
      t.string :tab
      t.string :mag_cp1
      t.string :mag_cp2
      t.string :mag_x64_cp1
      t.string :mag_x64_cp2
      t.string :mav_cp1
      t.string :mav_cp2

      t.timestamps
    end
  end

  def self.down
    drop_table :targets
  end
end
