class VenuesController < ApplicationController
  def show
    @venue = Venue.find_by(slug: params[:venue])
    @tickets = Ticket.where(event_id: @venue.events)
  end
end
