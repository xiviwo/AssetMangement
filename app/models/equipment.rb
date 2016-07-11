class Equipment < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
  	series_number :string
  	made_at	:date
  	buy_at	:date
  	guarantee_at	:date
  	enable_at	:date
  	discard_at		:date
  	reason_to_discard	:text
  	status	 enum_string('','使用中','维修','闲置','报废','修好')
  	made_in	:string
  	price	:float,:scale => 3
 	remark	:text
  	
    timestamps
  end
	belongs_to :model
	has_many :assignments
	
	has_many :repairs
	#has_one	:discard
	#belongs_to	:employee
	has_many :configurations,:accessible => true
	validates_presence_of :series_number,:model,:message => " blank is not allowed. "
	validates_uniqueness_of :series_number
	validates_associated :configurations
	belongs_to :owner,:class_name => "User",:creator => true
	
	def name
		self.model.name + " " + series_number
	end
	
	def after_initialize
  	if new_record?
	    self.made_at = Date.today
	    self.buy_at = Date.today
	    self.guarantee_at = Date.today
	   self.status = '闲置'
	end
  end
  	lifecycle do
  			 state :idle,:default => true
  			 state :assigned,:repairing,:repaired,:discard
  			 state :idle do
  			 	
  			 end
  			 state :assigned do
  			
  			 	end
  			 create :register,:params => [:series_number,:made_at,:buy_at,:guarantee_at,:model,:price,:configurations],:become => :idle,:available_to => "User",:user_becomes => :owner do
  			 		puts "create suceseed"
  			 		self.status = '闲置'
  			 		self.save(false)
  			 end	
  			 
  			 create :dump,:params => [:series_number,:buy_at,:guarantee_at,:model,:configurations,:discard_at,:reason_to_discard],:become => :discard,:available_to => "User",:user_becomes => :owner do
  			 		self.status = '报废'
  			 		self.save(false)	
  			 
  			 end 
  			 
  			 transition :assign,{ :idle => :assigned},:available_to => "User" do
  			 		if self.enable_at.nil?
  			 			self.enable_at = Date.today
  			 		    self.status = '使用中'
  			 		    self.save(false)
  			 		else 
  			 		self.status = '使用中'
  			 		self.save(false)
  			 		end
  			 end
  			 
  			 transition :cease_assign,{ :assigned => :idle },:available_to => "User" do
  			 		puts "assign happening"
  			 		self.status = '闲置'
  			 		self.save(false)
  			 		#self.enable_at = Date.today
  			 end
  			 transition  :repair,{:assigned => :repairing },:available_to => "User"  do
  			 		puts "repairing-----------------"
  			 		
  			 		self.status = '维修'
  			 		self.save(false)
  			 		
  			 end
  			 
  			 transition :repaired,{:repairing => :assigned },:available_to => "User" do
  			 		puts "repaired"
  			 		self.status = '修好'
  			 		self.save(false)
  			 		
  			 end
  			 
  			 transition :discard,{:repairing => :discard },:available_to => "User" do
  			 	
  			 		puts "dump"
  			 		if self.discard_at == nil
  			 			self.discard_at = Date.today
  			 		end
  			 		self.status = '报废'
  			 		self.save(false)
  			 		
  			 		self.assignments.each do |a|
  					
  			 		 if a.state == "valid"
  			 		 	
  			 		 	puts a.lifecycle.disable!(acting_user,{:employee => a.employee,:equipment => a.equipment,:assign_at => a.assign_at,:end_at =>Date.today})
  			 		 	
  			 		 end
  			 		 end
  			 		
  			 		
  			 end
  	end
  	
  	def do_assign
  		do_transition_action :assign do
  		 
  			redirect_to equipments_path
  		end
  	end
  	
  	def find_active_assignment
  	    return @assign = Assignment.find(:first,:conditions => {:state=>'valid',:equipment_id => self.id})
  	end
  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator? && self.state == "discard"
  end

  def view_permitted?(field)
    true
  end

end
