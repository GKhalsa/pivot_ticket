class Admin::EventsController < Admin::BaseController
  # before_action :set_event, only: [:edit, :update]

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
    @venue = params[:venue]
    @event = Event.find(params[:id])
  end

  def update

    @event = Event.find(params[:venue])
    if @event.update(event_params)
      flash[:success] = "#{@event.title} has been updated"
      redirect_to admin_venue_path(current_user.venue.slug)
    else
      flash.now[:errors] = @event.errors.full_messages
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:success] = "#{@event.title} has been deleted"
    redirect_to admin_venue_path(current_user.venue.slug)
  end

  private

  def event_params
    params.require(:event).permit(:title, :performing, :date, :category_id, :venue_id, :event_image, :id)
  end

  # def set_event
  #   binding.pry
  #   @event = Event.find(params[:id])
  # end
end
