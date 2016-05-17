class Admin::VenueModeratorsController < Admin::BaseController

  before_action :user_venue, only: [:new]

  def index
    @venue = Venue.find(params[:venue_id])
    @moderators = @venue.users
  end

  def show
  end

  def new
    if current_user.venue && current_user.business_admin?
      @venue = current_user.venue
    elsif current_user.platform_admin?
      @venue = Venue.find(params[:id])
    end
  end


  def create
    @venue = Venue.find(params[:venue])
    if @user = User.find_by(email: params[:email])
      @user.update(venue_id: @venue.id)
      @venue.users << @user
      flash[:notice] = "#{@user.name} has been added as an admin"
      redirect_to admin_venue_path(@venue.slug)
    else
      flash[:notice] = "This email could not be found"
      redirect_to new_admin_venue_moderator_path(id: @venue.id)
    end
  end

  def destroy
    @moderator = User.find(params[:id])
    @moderator.update(venue_id: nil)
    redirect_to request.referrer
  end

  private

    def user_venue
      @venue = current_user.venue
    end

end
