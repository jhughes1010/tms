class AddDateToSamples < ActiveRecord::Migration
  def self.up
    add_column :samples, :target, :date
  end

  def self.down
    remove_column :samples, :target
  end
end
