class Lifecycle < ActiveRecord::Migration
  def self.up
    add_column :equipment, :owner_id, :integer
    add_column :equipment, :state, :string, :default => "idle"
    add_column :equipment, :key_timestamp, :datetime

    add_index :equipment, [:owner_id]
    add_index :equipment, [:state]
  end

  def self.down
    remove_column :equipment, :owner_id
    remove_column :equipment, :state
    remove_column :equipment, :key_timestamp

    remove_index :equipment, :name => :index_equipment_on_owner_id rescue ActiveRecord::StatementInvalid
    remove_index :equipment, :name => :index_equipment_on_state rescue ActiveRecord::StatementInvalid
  end
end
