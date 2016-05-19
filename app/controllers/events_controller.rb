class EventsController < ApplicationController

  def show
    @event = Event.find(params[:id])
    @tickets = @event.tickets.where(status: 0).order(:seat_location)
    @venue = @event.venue
    @hash = Gmaps4rails.build_markers(@venue) do |venue, marker|
      marker.lat(venue.latitude)
      marker.lng(venue.longitude)
      marker.infowindow("<img src='http://photos3.meetupstatic.com/photos/member/1/9/c/0/highres_30966592.jpeg' height='140' width='140'> #{venue.address}".html_safe)
    end
  end

  def index
    @categories = Category.all
    @events = Event.order(:date)
    @venues = Venue.where(status: 1)
  end

end
