class AddPocAndStatus < ActiveRecord::Migration
  def self.up
    add_column :samples, :status, :string
    add_column :manids, :pocapp, :string
    add_column :manids, :pocmkt, :string
  end

  def self.down
    remove_column :samples, :status
    remove_column :manids, :pocapp
    remove_column :manids, :pocmkt
  end
end
