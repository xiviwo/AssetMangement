class Department < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
  	name	:string
  	number	:string
  	establish_at	:date
  	cancel_at	:date
  	status	:string
  	
    timestamps
  end
 	has_many 	:employees
	has_many	:sub_departments,:class_name => "Department",:foreign_key => "sub_id"
	belongs_to	:department,:class_name => "Department",:foreign_key => "sub_id"
	validates_presence_of :name
	validates_uniqueness_of :name
  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

end
