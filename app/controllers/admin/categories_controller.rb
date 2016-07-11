class Admin::CategoriesController < ApplicationController

  hobo_model_controller

  auto_actions :all
  auto_actions_for :parent_category,:create
end
