class Admin::VenuesController < ApplicationController
  include VenuesHelper

  before_action :set_venue

  def de_activate
    change_status(@venue, 2, "de-activated")
  end

  def activate
    change_status(@venue, 1, "activated")
  end

  private

  def set_venue
    @venue = Venue.find(params[:id])
  end

end
