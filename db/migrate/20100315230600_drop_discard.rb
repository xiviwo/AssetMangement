class DropDiscard < ActiveRecord::Migration
  def self.up
    drop_table :discards

    change_column :repairs, :state, :string, :default => "in_repair", :limit => 255
  end

  def self.down
    change_column :repairs, :state, :string, :default => "repairing"

    create_table "discards", :force => true do |t|
      t.date     "discard_at"
      t.text     "reason"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
