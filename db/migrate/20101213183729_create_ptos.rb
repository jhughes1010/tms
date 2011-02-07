class CreatePtos < ActiveRecord::Migration
  def self.up
    create_table :ptos do |t|
      t.integer :user_id
      t.date :start
      t.date :end
      t.string :comments

      t.timestamps
    end
  end

  def self.down
    drop_table :ptos
  end
end
