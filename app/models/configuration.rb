class Configuration < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
  	item	:string
  	value	:string
  	qty	:integer
	
    timestamps
  end
	belongs_to :equipment
 	validates_presence_of :item,:value
 	validates_uniqueness_of :item,:scope => :id
 	def name
 	    self.item + ":" + value +  (!qty.nil??  (" X" + self.qty.to_s): "")
 	end
 	
 	def after_initialize
  	if new_record?

	end
	end
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
