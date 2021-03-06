class Repair < ActiveRecord::Base

  hobo_model # Don't put anything above this
  after_validation :check
  
  fields do
  	report_at	:date
  	end_at	:date
  	#status	enum_string('true','false')
  	trouble	:text
  	result	:text
    timestamps
  end
	belongs_to :equipment
	#has_many :results
        belongs_to :contact
    
    	validates_presence_of :report_at,:trouble,:equipment,:contact
    	
    	def 	name
    		"Repairs at " + self.report_at.to_s
    	end
    	
    	def after_initialize
  	if new_record?
	    self.report_at = Date.today
	end
	end
	
	lifecycle do
		state :in_repair,:default => true
		state :has_repaired,:dump
		

		
		create :send_for_repair,:params => [:equipment,:contact,:report_at,:trouble],:available_to => "User",:become => :in_repair do
			if  self.equipment.state == "assigned"
					self.equipment.lifecycle.repair!(acting_user)
			
			end
		end
		
		
		create :add_history_repair,:params => [:equipment,:contact,:report_at,:end_at,:trouble,:result],:available_to => "User",:become => :has_repaired do
			if self.end_at == nil
				self.end_at = Date.today
				self.save()
				end
		end
		
		
		transition :get_repaired,{:in_repair => :has_repaired },:if => "self.equipment.state == 'repairing'",:params => [:equipment,:contact,:report_at,:end_at,:trouble,:result],:available_to => "User" do
				if self.end_at.nil?
				self.end_at = Date.today
				#self.status = "false"
				end
				self.save(false)
				
				
				if  self.equipment.state == "repairing"
					self.equipment.lifecycle.repaired!(acting_user)
				end
		end
		
		transition :dump,{:in_repair => :dump},:if => "self.equipment.state == 'repairing'",:params => [:equipment,:contact,:report_at,:end_at,:trouble,:result],:available_to => "User" do
				if self.end_at.nil?
				self.end_at = Date.today
				
				end
				self.equipment.reason_to_discard = self.result
				self.equipment.save(false)
				self.save(false)
				
				if  self.equipment.state == "repairing"
					self.equipment.lifecycle.discard!(acting_user)
					
				end
		end
		
	end
  	def check
  	
  		if !end_at.nil? && !report_at.nil?
	  		if end_at < report_at
			errors.add(:end_at,"结束日期不能小于开始日期")     
			end
		end

		
           if !equipment.nil? && state == "in_repair"
		   @repair = self.class.find(:last,:conditions => {:state => "in_repair",:equipment_id => equipment.id})
		   
		   if !@repair.nil? && @repair != self
		   errors.add(:equipment_id,"该设备已经在修理中,是否要结束上次修理? <a href='/repairs/#{@repair.id}/get_repaired'>是</a> 或者 <a href='/repairs/'>否</a> ")
	 	   	end
	 	   if equipment.state == "idle" 
  			errors.add(:equipment_id,"该设备未被分配，无法修理，<a href='/assignments/assign'>请先分配</a>")
  		   else if equipment.state != "assigned"
 	   		errors.add(:equipment_id,"设备在修 或在 报废，无法报修")
 	   		end
 	   	   end
 	   end
  	end
  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator?
  end

  def update_permitted?
    acting_user.administrator? && !equipment_changed?
  end

  def destroy_permitted?
    acting_user.administrator? && (self.state != "in_repair")
  end

  def view_permitted?(field)
    true
  end

end
