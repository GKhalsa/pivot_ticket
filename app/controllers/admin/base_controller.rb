class Admin::BaseController < ApplicationController

  def current_user_events
    current_user.venue.events
  end

  def pending_venue?
    current_user.venue.pending?
  end

  def authorize_business_admin
    current_user.venue && current_user.business_admin?
      @venue = current_user.venue
  end

  def current_venue?
    current_user.venue
  end

  def venue_pending?
    current_user.venue.pending?
  end

  def gather_venue_and_events
    @venue = current_user.venue
    @events = @venue.events.order(:date)
  end


end
