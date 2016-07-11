class Contact < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
  	name	:string
  	address	:string
  	phone	:string
  	
    timestamps
  end

	has_many :repairs
	
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
