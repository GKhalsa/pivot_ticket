module NavHelper
  def cart_contents
    set_cart.number_of_tickets
  end

  def link_to_dashboard
    if current_user && current_user.admin?
      link_to "Dashboard", admin_dashboard_path
    elsif current_user
      link_to "Dashboard", dashboard_path
    end
  end

  def link_to_venue_dashboard
    if current_user && current_user.business_admin? && current_user.venue
      venue = current_user.venue
      link_to "Venue", admin_venue_path(venue: venue.slug)
    elsif current_user && current_user.business_admin? && current_user.venue.nil?
      link_to "Venue", admin_venues_path
    end
  end
end
