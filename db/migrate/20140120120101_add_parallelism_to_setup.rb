class AddParallelismToSetup < ActiveRecord::Migration
  def self.up
    add_column :setups, :parallelism, :string
  end

  def self.down
    remove_column :setups, :parallelism
  end
end
