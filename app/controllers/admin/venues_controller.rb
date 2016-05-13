class Admin::VenuesController < ApplicationController

  def de_activate
    venue = Venue.find(params[:id])
    venue.status = 2
    flash.now[:success] = "venue_name was successfully de-activated"
  end

  def activate

  end

end
