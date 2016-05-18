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
    @venue = @event.venue
    @hash = Gmaps4rails.build_markers(@venue) do |venue, marker|
      marker.lat(venue.latitude)
      marker.lng(venue.longitude)
      marker.infowindow("<img src='http://photos3.meetupstatic.com/photos/member/1/9/c/0/highres_30966592.jpeg' height='140' width='140'> #{venue.address}".html_safe)
    end
    binding.pry
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
