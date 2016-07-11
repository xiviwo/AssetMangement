class Adddd < ActiveRecord::Migration
  def self.up
    remove_column :configurations, :status
    remove_column :configurations, :end_at
    remove_column :configurations, :set_at

    rename_column :models, :name, :model_name
    add_column :models, :vendor, :string
    add_column :models, :price, :float, :scale => 3
  end

  def self.down
    add_column :configurations, :status, :string
    add_column :configurations, :end_at, :date
    add_column :configurations, :set_at, :date

    rename_column :models, :model_name, :name
    remove_column :models, :vendor
    remove_column :models, :price
  end
end
