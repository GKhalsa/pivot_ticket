class TicketsController < ApplicationController
  def index
    @categories = Category.all
    @tickets = Ticket.all_by_state
    @venues = Venue.all
  end

  def show

  end
end
