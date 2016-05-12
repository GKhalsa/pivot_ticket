class Admin::EventsController < Admin::BaseController
  before_action :set_event, only: [:retire, :activate, :edit, :update]

  def index
    @events = Event.all_by_id
  end

  def retire
    @event.retired!
    redirect_to admin_events_path
  end

  def activate
    @event.active!
    redirect_to admin_events_path
  end

  def new
    @categories = Category.all
    @event = Event.new
  end

  def create
    @event = Event.new(ticket_params)
    if @event.save
      redirect_to admin_events_path
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

  def ticket_params
    params.require(:event).permit(:price, :avatar, :category_id, :event_id, :seat_location)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
