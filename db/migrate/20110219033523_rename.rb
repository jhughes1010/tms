class Rename < ActiveRecord::Migration
  def self.up
    rename_column :ptos, :end, :finish
  end

  def self.down
        rename_column :ptos, :finish , :end
  end
end
