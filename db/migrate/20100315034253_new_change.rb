class NewChange < ActiveRecord::Migration
  def self.up
    remove_column :results, :repair_id

    remove_column :discards, :equipment_id

    rename_column :equipment, :configure, :remark
    add_column :equipment, :reason_to_discard, :text

    add_column :repairs, :result, :text
    add_column :repairs, :state, :string, :default => "repairing"
    add_column :repairs, :key_timestamp, :datetime
    remove_column :repairs, :status

    remove_column :assignments, :status

    remove_index :results, :name => :index_results_on_repair_id rescue ActiveRecord::StatementInvalid

    remove_index :discards, :name => :index_discards_on_equipment_id rescue ActiveRecord::StatementInvalid

    add_index :repairs, [:state]
  end

  def self.down
    add_column :results, :repair_id, :integer

    add_column :discards, :equipment_id, :integer

    rename_column :equipment, :remark, :configure
    remove_column :equipment, :reason_to_discard

    remove_column :repairs, :result
    remove_column :repairs, :state
    remove_column :repairs, :key_timestamp
    add_column :repairs, :status, :string

    add_column :assignments, :status, :string

    add_index :results, [:repair_id]

    add_index :discards, [:equipment_id]

    remove_index :repairs, :name => :index_repairs_on_state rescue ActiveRecord::StatementInvalid
  end
end
