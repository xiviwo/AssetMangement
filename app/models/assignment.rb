class Assignment < ActiveRecord::Base

  hobo_model # Don't put anything above this

   after_validation :check
   before_destroy :set_idle
   before_update :check_state
  fields do
  	assign_at 	:date
  	end_at	:date	
    timestamps
  end
	belongs_to 	:equipment
	belongs_to	:employee
	validates_presence_of :assign_at,:equipment,:employee
	#validates_uniqueness_of :equipment,:scope => [:employee,:assign_at],:message => " equipment can't be assigned twice",:on => :update
	#validates_associated
	def name
		"Assigned to " + self.employee.name
	end 
	
	def after_initialize
	  	if new_record?
		    self.assign_at = Date.today

		end
	end


	lifecycle do
		state :valid,:default => true
		state :expired
		
		create :assign,:params=> [:employee,:equipment,:assign_at],:available_to => "User",:become => :valid do
		
				if  self.equipment.state == "idle"
					self.equipment.lifecycle.assign!(acting_user)
			
				end
		end
		
		create :add_history,:params => [:employee,:equipment,:assign_at,:end_at],:available_to => "User",:become => :expired do
				if self.end_at == nil
				
				self.end_at == Date.today
				self.save(false)
				
				end
		end
		
		transition :disable,{:valid => :expired},:if => "(self.equipment.state == 'assigned' || self.equipment.state == 'discard')",:params => [:employee,:equipment,:assign_at,:end_at],:available_to => "User" do
				if self.end_at.nil?
				self.end_at = Date.today
				self.save(false)
				end
				
				
				
				if  self.equipment.state == "assigned"
					self.equipment.lifecycle.cease_assign!(acting_user)
				end
		end
		

	
	end
	
 	def set_idle
 		if self.state == "valid" 
 			if self.equipment.state == "assigned"
			 	self.equipment.lifecycle.cease_assign!(acting_user)	
			 
			 	end
 		end
 		
 	end
 	
 	  def check_state
 	  
 	    	#if end_at == nil && status != "true"  
  		#	errors.add(:status, "状态不正常，状态应该是true")	
  		#else if end_at != nil &&   status =="true"
  		#	errors.add(:status, "状态不正常，状态应该是false")
  		#	end
  		#end
  		if self.state == "expired"
  		     if self.end_at.nil?
  		     	errors.add(:end_at,"这项不能空")
  		     	else if end_at < assign_at
  		     	errors.add(:end_at,"结束日期不能小于开始日期")
  		     	end
  		     end
  		     
  		else if !self.end_at.nil?
  			errors.add(:end_at,"这项不能填入，因为这项记录有效中")
  			end
  		end
 	  end
 	  
# to ensure properly input and only one "true" equipment is alive 	
	  def check

  		if !end_at.nil? && !assign_at.nil?
	  		if end_at < assign_at
			errors.add(:end_at,"结束日期不能小于开始日期")     
			end
		end
		
		
           if !equipment.nil? && state == "valid"
           
           	   if equipment.state == 'assigned'
			   @assign = self.class.find(:last,:conditions => {:state => "valid",:equipment_id => equipment.id})
			   
			   if !@assign.nil? && @assign != self
			   errors.add(:equipment_id,"该设备已经分配#{@assign.employee.name},是否要停止上次分配，再次分配#{"给"+employee.name unless employee.nil?}? <a href='/assignments/#{@assign.id}/disable'>是</a> 或者 <a href='/assignments/'>否</a> ")
		 	   end
	 	   
	 	   end
	 	   
	 	   if equipment.state != 'idle' &&  equipment.state != 'assigned'
			errors.add(:equipment_id,"状态不正常，可能报废了或者送修了")	
		   end
 	   
 	   end
		 		
         end
         

        


def assign
	creator_page_action :assign do
    redirect_to "/assignments"
    end
end 

def add_history
	creator_page_action :add_history do
    redirect_to "/assignments"
    end
end 
def disable
	 transition_page_action  :disable do
    redirect_to "/assignments"
    end
end 
def enable
	 transition_page_action  :enable do
    redirect_to "/assignments"
    end
end 

  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator?
  end

  def update_permitted?
    acting_user.administrator? && (only_changed? :assign_at,:end_at)
  end

  def destroy_permitted?
    acting_user.administrator? && (self.state == 'expired')
  end

  def view_permitted?(field)
    true
  end

end
