class VenuesController < ApplicationController
  def show
    @venue = Venue.find_by(slug: params[:venue])
    @events = @venue.events
  end
end
