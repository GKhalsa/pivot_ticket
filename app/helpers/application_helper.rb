module ApplicationHelper
  def link_to_login_or_logout
    if current_user
      link_to "Logout", logout_path, method: :delete
    else
      link_to "Login", login_path
    end
  end

  def venue_active?(venue)
    if venue.active?
      button_to "de-activate venue",
      admin_venue_deactivate_path(venue.id),
      class: "#{venue.name}-de-activate waves-effect waves-light red lighten-1 btn"
    else
      button_to "activate venue",
      admin_venue_activate_path(venue.id),
      class: "#{venue.name}-activate waves-effect waves-light btn"
    end
  end

  def venue_alerts?(venue)
    if venue.alerts?
     link_to "!", alerts_path, class: "btn-floating btn-small waves-effect waves-light red"
    end
  end
end
