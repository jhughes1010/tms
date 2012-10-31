class AddProductToResources < ActiveRecord::Migration
  def self.up
    add_column :resources, :product_line, :string
  end

  def self.down
    remove_column :resources, :product_line, :string
  end
end
