class AddOwner < ActiveRecord::Migration
  def self.up
        add_column :sas, :owner, :string
  end

  def self.down
    remove_column :sas, :owner
  end
end
