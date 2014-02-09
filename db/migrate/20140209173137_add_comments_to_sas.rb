class AddCommentsToSas < ActiveRecord::Migration
  def self.up
         add_column :sas, :comment, :text
  end

  def self.down
     remove_column :sas, :comment
  end
end
