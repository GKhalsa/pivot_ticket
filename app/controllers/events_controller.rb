class EventsController < ApplicationController

  def show
    @event = Event.find(params[:id])
    @tickets = @event.tickets.where(status: 0)
  end

  def index
    @categories = Category.all
    @events = Event.order(:date)
    @venues = Venue.where(status: 1)
  end

end
