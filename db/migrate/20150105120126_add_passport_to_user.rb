class AddPassportToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :passport, :date
  end

  def self.down
    remove_column :users, :passport
  end
end
