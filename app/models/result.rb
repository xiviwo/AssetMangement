class Result < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
  	report_at	:date
  	report	:text
  	status	enum_string('true','false')
    timestamps
  end

         #belongs_to :repair
  	validates_presence_of :repair
  	
   def after_initialize
  	if new_record?
	    self.report_at = Date.today

	   self.status = 'true'

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
