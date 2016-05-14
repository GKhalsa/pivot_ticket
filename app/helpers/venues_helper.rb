module VenuesHelper
  
  def change_status(venue, status, message)
    venue.status = status
    venue.save
    flash[:success] = "#{venue.name} was successfully #{message}"
    redirect_to admin_dashboard_path
  end

end
