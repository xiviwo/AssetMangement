class ChangeName < ActiveRecord::Migration
  def self.up
    rename_column :equipment, :identity, :series_number
  end

  def self.down
    rename_column :equipment, :series_number, :identity
  end
end
