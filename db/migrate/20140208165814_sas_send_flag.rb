class SasSendFlag < ActiveRecord::Migration
  def self.up
     add_column :sas, :sas_type, :string
      add_column :sas, :sent, :boolean
  end

  def self.down
    add_column :sas, :sas_type
     add_column :sas, :sent
  end
end
