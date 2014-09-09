class AddUserToSas < ActiveRecord::Migration
  def self.up
    add_column :sas, :user_id, :integer
  end

  def self.down
    remove_column :sas, :user_id
  end
end
