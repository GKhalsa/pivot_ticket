class Admin::DashboardController < Admin::BaseController
  def show
    @venues = Venue.all
  end
end
