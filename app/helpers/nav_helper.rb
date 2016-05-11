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
end
