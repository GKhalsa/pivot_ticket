class Admin::BaseController < ApplicationController

  def current_user_events
    current_user.venue.events
  end

  def pending_venue?
    current_user.venue.pending?
  end
end
