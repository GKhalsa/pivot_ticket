class Admin::EventsController < Admin::BaseController
  before_action :set_event, only: [:edit, :update]

  def index
    @events = Event.all_by_id
  end

  def new
    @categories = Category.all
    @event = Event.new
    @venue = params[:venue]
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      current_user.venue.events << @event
      redirect_to admin_venue_path(current_user.venue.slug)
    else
      flash[:notice] = @event.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
  end

  def update
    @event.update(ticket_params)
    redirect_to admin_events_path
  end

  private

  def event_params
    params.require(:event).permit(:title, :performing, :date, :category_id, :venue_id, :event_image)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
