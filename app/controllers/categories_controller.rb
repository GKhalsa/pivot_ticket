class CategoriesController < ApplicationController
  def show
    @categories = Category.all
    @category = Category.find_by_name(params)
    @venues = Venue.where(status: 1)
    @events  = @category.events.where(venue: @venues).order(:date)
  end
end
