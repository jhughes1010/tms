class AddCrs < ActiveRecord::Migration
  def self.up
    add_column :test_progs, :crs_number, :string
  end

  def self.down
    remove_column :test_progs, :crs_number, :string
  end
end
