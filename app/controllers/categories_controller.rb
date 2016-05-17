class CategoriesController < ApplicationController
  def show
    @categories = Category.all
    @category = Category.find_by_name(params)
    @events  = @category.events
    @venues = Venue.all
  end
end
