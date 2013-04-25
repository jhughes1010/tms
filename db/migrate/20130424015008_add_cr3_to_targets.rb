class AddCr3ToTargets < ActiveRecord::Migration
  def self.up
     add_column :targets, :cr3, :boolean
  end

  def self.down
    remove_column :targets, :cr3
  end
end
