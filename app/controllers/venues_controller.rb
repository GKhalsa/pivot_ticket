class VenuesController < ApplicationController
  def show
    @venue = Venue.find_by(slug: params[:venue])
    @venues = Venue.all
    @events = @venue.events
    @categories = Category.all
  end
end
