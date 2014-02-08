class CreateSas < ActiveRecord::Migration
  def self.up
    create_table :sas do |t|
      t.string :lot_number
      t.string :location
      t.string :plant
      t.string :profit_center
      t.string :sap_matid
      t.string :lts_matid
      t.integer :quantity
      t.float :standard_cost
      t.float :total
      t.datetime :date
      t.float :reserve
      t.string :rma
      t.string :customer_number
      t.string :customer_details
      t.float :total_std_cost

      t.timestamps
    end
  end

  def self.down
    drop_table :sas
  end
end
