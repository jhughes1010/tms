class RenameCan < ActiveRecord::Migration
  def self.up
        change_column :manids, :can_id, :string
  end

  def self.down
    change_column :manids, :can_id, :integer
  end
end
