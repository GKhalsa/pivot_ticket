class VenuesController < ApplicationController
  def show
    @venue = Venue.find_by_name(params)
    @venues = Venue.all
    @events = @venue.events.order(:date)
    @categories = Category.all
  end
end
