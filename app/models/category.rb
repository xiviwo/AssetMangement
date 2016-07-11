class Category < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
  	name	:string
    timestamps
  end
	has_many :models
	has_many :sub_categories,:class_name => "Category",:foreign_key => "category_id"
	belongs_to :parent_category,:class_name => "Category",:foreign_key => "category_id"
	validates_presence_of :name
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
