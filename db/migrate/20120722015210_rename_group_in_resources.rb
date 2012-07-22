class RenameGroupInResources < ActiveRecord::Migration
  def self.up
    rename_column :resources, :group, :team
  end

  def self.down
    rename_column :resources, :team, :group
  end
end
