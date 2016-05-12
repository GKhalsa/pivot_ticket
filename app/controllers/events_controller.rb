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
    @tickets = @event.tickets
  end

  def index
    @categories = Category.all
    @events = Event.all
    @venues = Venue.all
  end

  private

  def event_params
    params.require(:event).permit(:title, :performing, :date, :category_id, :venue_id, :avatar)
  end
end