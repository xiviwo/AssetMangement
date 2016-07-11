class AssignmentsController < ApplicationController

  hobo_model_controller

  auto_actions :all

  auto_actions_for :equipment,:create
  
  #show_action :close_last
 

  	  def index

		
		 hobo_index Assignment.apply_scopes(:search => [params[:search],:assign_at,:end_at,:state]
	
		 								 )
		
	 end 
  	def print
		if !params[:id].nil?
		@s = params[:id].collect{|t| t.gsub("\\-","").to_i}

	 	@assignments =self.model.find(:all,:conditions => { :id => @s })
		else 
		@assignments = nil
		end

	end  
end
