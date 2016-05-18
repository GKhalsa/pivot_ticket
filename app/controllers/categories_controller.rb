class CategoriesController < ApplicationController
  def show
    @categories = Category.all
    @category = Category.find_by_name(params)
    @events  = @category.events.order(:date)
    @venues = Venue.all
  end
end
