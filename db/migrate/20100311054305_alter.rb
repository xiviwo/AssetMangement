class Alter < ActiveRecord::Migration
  def self.up
    add_column :equipment, :employee_id, :integer

    add_column :people, :type, :string
    add_column :people, :employee_number, :string
    add_column :people, :department_id, :integer

    add_index :equipment, [:employee_id]

    add_index :people, [:type]
    add_index :people, [:department_id]
  end

  def self.down
    remove_column :equipment, :employee_id

    remove_column :people, :type
    remove_column :people, :employee_number
    remove_column :people, :department_id

    remove_index :equipment, :name => :index_equipment_on_employee_id rescue ActiveRecord::StatementInvalid

    remove_index :people, :name => :index_people_on_type rescue ActiveRecord::StatementInvalid
    remove_index :people, :name => :index_people_on_department_id rescue ActiveRecord::StatementInvalid
  end
end
