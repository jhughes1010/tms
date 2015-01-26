class AddColToSamples < ActiveRecord::Migration
  def self.up
    add_column :samples, :crs, :string
  end

  def self.down
    remove_column :samples, :crs, :string
  end
end
