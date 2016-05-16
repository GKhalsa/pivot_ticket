class EventsController < ApplicationController

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to events_path
    else
      flash[:notice] = @event.errors.full_messages.join(", ")
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
    @tickets = @event.tickets.where(status: 0)
  end

  def index
    @categories = Category.all
    @events = Event.all
    @venues = Venue.where(status: 1)
  end

  private

  def event_params
    params.require(:event).permit(:title, :performing, :date, :category_id, :venue_id, :event_image)
  end
end
