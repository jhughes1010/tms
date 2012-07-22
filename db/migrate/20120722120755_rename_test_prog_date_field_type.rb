class RenameTestProgDateFieldType < ActiveRecord::Migration
  def self.up
    change_column :test_progs, :date_received, :date
  end

  def self.down
    change_column :test_progs, :date_received, :string
  end
end
