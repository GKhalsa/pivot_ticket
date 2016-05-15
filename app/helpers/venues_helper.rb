module VenuesHelper

  def change_status(venue, status, message)
    venue.status = status
    venue.save
    flash[:notice] = "#{venue.name} was successfully #{message}"
  end

end
