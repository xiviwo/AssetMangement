class Start < ActiveRecord::Migration
  def self.up
    create_table :results do |t|
      t.date     :report_at
      t.text     :report
      t.string   :status
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :repair_id
    end
    add_index :results, [:repair_id]

    create_table :configurations do |t|
      t.string   :name
      t.string   :value
      t.date     :set_at
      t.date     :end_at
      t.string   :status
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :equipment_id
    end
    add_index :configurations, [:equipment_id]

    create_table :departments do |t|
      t.string   :name
      t.string   :number
      t.date     :establish_at
      t.date     :cancel_at
      t.string   :status
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :discards do |t|
      t.date     :discard_at
      t.text     :reason
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :equipment_id
    end
    add_index :discards, [:equipment_id]

    create_table :categories do |t|
      t.string   :name
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :category_id
    end
    add_index :categories, [:category_id]

    create_table :assignments do |t|
      t.date     :assign_at
      t.date     :end_at
      t.string   :status
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :equipment_id
    end
    add_index :assignments, [:equipment_id]

    create_table :equipment do |t|
      t.string   :identity
      t.date     :made_at
      t.date     :buy_at
      t.date     :guarantee_at
      t.date     :enable_at
      t.date     :discard_at
      t.string   :status
      t.string   :made_in
      t.float    :price, :scale => 2
      t.text     :configure
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :model_id
    end
    add_index :equipment, [:model_id]

    create_table :people do |t|
      t.string   :name
      t.string   :gender
      t.string   :identity
      t.date     :date_of_birth
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :contacts do |t|
      t.string   :name
      t.string   :address
      t.string   :phone
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :repairs do |t|
      t.date     :report_at
      t.date     :end_at
      t.string   :status
      t.text     :trouble
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :equipment_id
      t.integer  :contact_id
    end
    add_index :repairs, [:equipment_id]
    add_index :repairs, [:contact_id]

    create_table :models do |t|
      t.string   :name
      t.string   :brand
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :category_id
    end
    add_index :models, [:category_id]
  end

  def self.down
    drop_table :results
    drop_table :configurations
    drop_table :departments
    drop_table :discards
    drop_table :categories
    drop_table :assignments
    drop_table :equipment
    drop_table :people
    drop_table :contacts
    drop_table :repairs
    drop_table :models
  end
end
