class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :fullname
      t.string :name
      t.string :hashed_password
      t.string :salt
      t.string :department

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
