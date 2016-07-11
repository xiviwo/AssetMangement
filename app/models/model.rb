class Model < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    model_name	:string
    #model_type	:string
    brand	:string
  	vendor	:string
 	price	:float,:scale => 3
  	timestamps
    
  end

	has_many	:equipments
	belongs_to 	:category
	
	validates_presence_of :model_name,:brand,:category,:message=> "not blank"
	validates_uniqueness_of :model_name
	
	def name 
		self.brand + " " + ( self.category.nil?? "" : self.category.name )
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
