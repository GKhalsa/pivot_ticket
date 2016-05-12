class CategoriesController < ApplicationController
  def show
    @categories = Category.all
    @category = Category.find_by(name: params[:name]) || not_found
    @events  = @category.events
  end
end
