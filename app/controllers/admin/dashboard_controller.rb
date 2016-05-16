class Admin::DashboardController < Admin::BaseController
  def show
    @venues = Venue.all.order(:status)
  end
end
