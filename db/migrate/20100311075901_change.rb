class Change < ActiveRecord::Migration
  def self.up
    add_column :departments, :sub_id, :integer

    add_column :assignments, :employee_id, :integer

    add_index :departments, [:sub_id]

    add_index :assignments, [:employee_id]
  end

  def self.down
    remove_column :departments, :sub_id

    remove_column :assignments, :employee_id

    remove_index :departments, :name => :index_departments_on_sub_id rescue ActiveRecord::StatementInvalid

    remove_index :assignments, :name => :index_assignments_on_employee_id rescue ActiveRecord::StatementInvalid
  end
end
