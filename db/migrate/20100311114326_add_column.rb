class AddColumn < ActiveRecord::Migration
  def self.up
    add_column :configurations, :qty, :integer
  end

  def self.down
    remove_column :configurations, :qty
  end
end
