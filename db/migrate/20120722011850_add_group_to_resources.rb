class AddGroupToResources < ActiveRecord::Migration
  def self.up
    add_column :resources, :group, :string
  end

  def self.down
    remove_column :resources, :group
  end
end
