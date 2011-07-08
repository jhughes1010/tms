class CreateCanSubs < ActiveRecord::Migration
  def self.up
    create_table :can_subs do |t|
      t.integer :can_main_id
      t.string :cpn
      t.string :mpn
      t.string :package
      t.text :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :can_subs
  end
end
