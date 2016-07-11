class ChangeConfig < ActiveRecord::Migration
  def self.up
    rename_column :configurations, :name, :item
  end

  def self.down
    rename_column :configurations, :item, :name
  end
end
