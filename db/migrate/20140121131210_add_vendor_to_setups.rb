class AddVendorToSetups < ActiveRecord::Migration
  def self.up
        add_column :setups, :vendor, :string
  end

  def self.down
        remove_column :setups, :vendor
  end
end
