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

  def change_status(ticket, status, message)
    ticket.status = status
    ticket.save
    flash[:notice] = "Your ticket to #{ticket.event.title} was successfully #{message}"
  end

end
