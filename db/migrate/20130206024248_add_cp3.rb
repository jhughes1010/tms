class AddCp3 < ActiveRecord::Migration
  def self.up
    add_column :targets, :mag_cp3, :string
    add_column :targets, :mag_x64_cp3, :string
    add_column :targets, :mav_cp3, :string
  end

  def self.down
    remove_column :targets, :mag_cp3
    remove_column :targets, :mag_x64_cp3
    remove_column :targets, :mav_cp3
  end
end
