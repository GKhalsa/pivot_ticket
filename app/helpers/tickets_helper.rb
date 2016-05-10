module TicketsHelper
  def checkout_or_create_account_button
    if current_user
      button_to "Checkout", orders_path, class: "waves-effect waves-light btn"
    else
      button_to "Create Account to Checkout",
                login_path,
                method: "get",
                class: "waves-effect waves-light btn"
    end
  end

  def button_to_change_ticket_state(ticket)
    if ticket.active?
      link_to "Retire",
              admin_retire_path(ticket),
              method: :patch,
              class: "waves-effect waves-light btn"
    else
      link_to "Activate",
              admin_activate_path(ticket),
              method: :patch,
              class: "waves-effect waves-light btn"
    end
  end
end
