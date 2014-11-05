class CreateSamples < ActiveRecord::Migration
  def self.up
    create_table :samples do |t|
      t.integer :manid_id
      t.date :dateExchange
      t.date :dateSamples
      t.date :dateCustApproval
      t.date :dateQAEnable
      t.date :dateReleaseProduction

      t.timestamps
    end
  end

  def self.down
    drop_table :samples
  end
end
