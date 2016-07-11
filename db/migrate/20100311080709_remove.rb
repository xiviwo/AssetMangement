class Remove < ActiveRecord::Migration
  def self.up
    remove_column :equipment, :employee_id

    remove_index :equipment, :name => :index_equipment_on_employee_id rescue ActiveRecord::StatementInvalid
  end

  def self.down
    add_column :equipment, :employee_id, :integer

    add_index :equipment, [:employee_id]
  end
end
