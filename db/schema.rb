# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100316152120) do

  create_table "assignments", :force => true do |t|
    t.date     "assign_at"
    t.date     "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "equipment_id"
    t.integer  "employee_id"
    t.string   "state",         :default => "valid"
    t.datetime "key_timestamp"
  end

  add_index "assignments", ["employee_id"], :name => "index_assignments_on_employee_id"
  add_index "assignments", ["equipment_id"], :name => "index_assignments_on_equipment_id"
  add_index "assignments", ["state"], :name => "index_assignments_on_state"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
  end

  add_index "categories", ["category_id"], :name => "index_categories_on_category_id"

  create_table "configurations", :force => true do |t|
    t.string   "item"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "equipment_id"
    t.integer  "qty"
  end

  add_index "configurations", ["equipment_id"], :name => "index_configurations_on_equipment_id"

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.string   "number"
    t.date     "establish_at"
    t.date     "cancel_at"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sub_id"
  end

  add_index "departments", ["sub_id"], :name => "index_departments_on_sub_id"

  create_table "equipment", :force => true do |t|
    t.string   "series_number"
    t.date     "made_at"
    t.date     "buy_at"
    t.date     "guarantee_at"
    t.date     "enable_at"
    t.date     "discard_at"
    t.string   "status"
    t.string   "made_in"
    t.float    "price"
    t.text     "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "model_id"
    t.integer  "owner_id"
    t.string   "state",             :default => "idle"
    t.datetime "key_timestamp"
    t.text     "reason_to_discard"
  end

  add_index "equipment", ["model_id"], :name => "index_equipment_on_model_id"
  add_index "equipment", ["owner_id"], :name => "index_equipment_on_owner_id"
  add_index "equipment", ["state"], :name => "index_equipment_on_state"

  create_table "models", :force => true do |t|
    t.string   "model_name"
    t.string   "brand"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.string   "vendor"
    t.float    "price"
  end

  add_index "models", ["category_id"], :name => "index_models_on_category_id"

  create_table "people", :force => true do |t|
    t.string   "name"
    t.string   "gender"
    t.string   "identity"
    t.date     "date_of_birth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.string   "employee_number"
    t.integer  "department_id"
  end

  add_index "people", ["department_id"], :name => "index_people_on_department_id"
  add_index "people", ["type"], :name => "index_people_on_type"

  create_table "repairs", :force => true do |t|
    t.date     "report_at"
    t.date     "end_at"
    t.text     "trouble"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "equipment_id"
    t.integer  "contact_id"
    t.text     "result"
    t.string   "state",         :default => "in_repair"
    t.datetime "key_timestamp"
  end

  add_index "repairs", ["contact_id"], :name => "index_repairs_on_contact_id"
  add_index "repairs", ["equipment_id"], :name => "index_repairs_on_equipment_id"
  add_index "repairs", ["state"], :name => "index_repairs_on_state"

  create_table "results", :force => true do |t|
    t.date     "report_at"
    t.text     "report"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "name"
    t.string   "email_address"
    t.boolean  "administrator",                           :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",                                   :default => "active"
    t.datetime "key_timestamp"
  end

  add_index "users", ["state"], :name => "index_users_on_state"

end
