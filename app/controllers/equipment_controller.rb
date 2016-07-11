class EquipmentController < ApplicationController

  hobo_model_controller

  auto_actions :all
  
  #auto_actions_for :assignments,:create
  
  	  def index

		
		 hobo_index Equipment.apply_scopes(:search => [params[:search],:series_number,:buy_at,:status,:state,:price]
	
		 								 )
		
	 end 
	 
  	def print
		if !params[:id].nil?
		@s = params[:id].collect{|t| t.gsub("\\-","").to_i}
		
	 	@equipment =self.model.find(:all,:conditions => { :id => @s })
	 	
		else 
		@equipment = nil
		end

	 	
	end
end
