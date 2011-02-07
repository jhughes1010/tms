class AddColToUsers < ActiveRecord::Migration
  def self.up
         add_column :users, :auth_level, :integer   
  end

  def self.down
        remove_column :users, :auth_level
  end
end
