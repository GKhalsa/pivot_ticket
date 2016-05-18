class Admin::VenuesController < Admin::BaseController
  include VenuesHelper

  before_action :set_venue, only: [:de_activate, :activate, :edit, :update, :show]
  before_action :user_venue, only: [:show, :create]


  def de_activate
    change_status(@venue, 2, "de-activated")
    redirect_to admin_dashboard_path
  end

  def activate
    change_status(@venue, 1, "activated")
    redirect_to admin_dashboard_path
  end

  def show
    if venue_pending?
      render :pending
    elsif current_user.platform_admin?
      @venue = Venue.find_by(slug: params[:venue])
      @events = @venue.events.order(:date)
    elsif current_user.business_admin?
      gather_venue_and_events
    elsif current_user.registered_user?
      current_user.roles << Role.business_admin
      gather_venue_and_events
    else
      render file: 'public/404'
    end
  end

  def index

  end

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.new(venue_params)
    if @venue.save
      current_user.update(venue_id: @venue.id)
      render :pending
    else
      flash.now[:error] = @venue.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if @venue.update(venue_params)
      flash[:success] = "#{@venue.name} has been successfully updated"
      redirect_to admin_venue_path(@venue.slug)
    else
      flash.now[:error] = @venue.errors.full_messages
      render :edit
    end
  end

  def destroy

  end

  private

    def venue_params
      params.require(:venue).permit(:name, :address, :image, :status)
    end

    def set_venue
      @venue = Venue.find(params[:id])
    end

    def user_venue
      @venue = current_user.venue
    end
end
