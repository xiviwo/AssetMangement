class RepairsController < ApplicationController

  hobo_model_controller

  auto_actions :all
#auto_actions_for :equipment,:create




  	def print
		if !params[:id].nil?
		@s = params[:id].collect{|t| t.gsub("\\-","").to_i}

	 	@repairs =self.model.find(:all,:conditions => { :id => @s })
		else 
		@repairs = nil
		end

	 	
	end
end
