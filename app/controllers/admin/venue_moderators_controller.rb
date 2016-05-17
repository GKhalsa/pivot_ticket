class Admin::VenueModeratorsController < Admin::BaseController

  before_action :user_venue, only: [:new, :create]

  def index
    @venue = Venue.find(params[:venue_id])
    @moderators = @venue.users
  end

  def show
  end

  def new
  end

  def create
    if @user = User.find_by(email: params[:email])
      @venue.users << @user
      flash[:success] = "#{@user.name} has been added as an admin"
      redirect_to admin_venue_path(@venue.slug)
    else
      flash[:error] = "This email could not be found"
      redirect_to new_admin_venue_moderator_path
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
