class CreateResources < ActiveRecord::Migration
  def self.up
    create_table :resources do |t|
      t.date :date
      t.string :department
      t.string :name
      t.string :project
      t.string :function
      t.decimal :actual
      t.decimal :forecast

      t.timestamps
    end
  end

  def self.down
    drop_table :resources
  end
end
