class Employee < Person

  hobo_model # Don't put anything above this

  fields do
  	employee_number	:string
  end
  
  has_many :assignments
  belongs_to :department
  
  #has_many :equipments,:through => :assignments
  
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
