class AddMatchFlagsToSetup < ActiveRecord::Migration
  def self.up
    add_column :setups, :cp1_match_flag, :integer
    add_column :setups, :cp2_match_flag, :integer
    add_column :setups, :cp3_match_flag, :integer
  end

  def self.down
    remove_column :setups, :cp1_match_flag
    remove_column :setups, :cp2_match_flag
    remove_column :setups, :cp3_match_flag
  end
end
