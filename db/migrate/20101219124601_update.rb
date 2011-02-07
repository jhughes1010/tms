class Update < ActiveRecord::Migration
  def self.up
    rename_column :tasks, :type, :category
  end

  def self.down
        rename_column :tasks, :category, :type
  end
end
