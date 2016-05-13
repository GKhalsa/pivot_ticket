class Admin::VenuesController < ApplicationController

  def de_activate
    venue = Venue.find(params[:id])
    venue.status = 2
    venue.save
    flash[:success] = "#{venue.name} was successfully de-activated"
    redirect_to admin_dashboard_path
  end

  def activate

  end

end
