class Admin::VenuesController < Admin::BaseController
  include VenuesHelper

  before_action :set_venue, only: [:de_activate, :activate]


  def de_activate
    change_status(@venue, 2, "de-activated")
    redirect_to admin_dashboard_path
  end

  def activate
    change_status(@venue, 1, "activated")
    redirect_to admin_dashboard_path
  end

  def show
    if current_user.venue && current_user.venue.pending?
      render :pending
    elsif current_user.platform_admin?
      @venue = Venue.find_by(slug: params[:venue]) || Venue.find(params[:venue])
      @events = @venue.events
    elsif current_user.business_admin?
      @venue = current_user.venue
      @events = @venue.events
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

  def edit
    @venue = Venue.find(params[:id])
  end

  def update
    @venue = Venue.find(params[:id])
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
end
