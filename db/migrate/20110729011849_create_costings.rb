class CreateCostings < ActiveRecord::Migration
  def self.up
    create_table( :costings, :force => true) do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :costings
  end
end
