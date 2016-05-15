class Admin::VenuesController < Admin::BaseController

  def show
    if current_user.venue.pending?
      render :pending
    else
      @venue = current_user.venue
    end
    @events = @venue.events
  end

  def index

  end

  def new
    @venue = Venue.new
  end

  def create
    @user_venue = current_user.venue
    @user_venue = Venue.new(venue_params)
    if @user_venue.save
      current_user.update(venue_id: @user_venue.id)
      render :pending
    else
      flash.now[:error] = @user_venue.errors.full_messages
      render :new
    end
  end

  private

    def venue_params
      params.require(:venue).permit(:name, :address, :image, :approved)
    end

end
