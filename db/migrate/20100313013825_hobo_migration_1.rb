class HoboMigration1 < ActiveRecord::Migration
  def self.up
    add_column :assignments, :state, :string, :default => "valid"
    add_column :assignments, :key_timestamp, :datetime

    add_index :assignments, [:state]
  end

  def self.down
    remove_column :assignments, :state
    remove_column :assignments, :key_timestamp

    remove_index :assignments, :name => :index_assignments_on_state rescue ActiveRecord::StatementInvalid
  end
end
