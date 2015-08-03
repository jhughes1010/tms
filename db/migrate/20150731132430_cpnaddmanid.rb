class Cpnaddmanid < ActiveRecord::Migration
  def self.up
    add_column :manids, :cpn, :string
  end

  def self.down
    remove_column :manids, :cpn
  end
end
