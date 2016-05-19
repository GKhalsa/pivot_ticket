class CartsController < ApplicationController
  before_action :set_ticket, only: [:create, :destroy]

  def create
    @cart.add_ticket(@ticket.id)
    session[:cart] = @cart.contents
    redirect_to request.referrer
  end

  def destroy
    @cart.delete_ticket(@ticket.id)
    session[:cart] = @cart.contents

    flash[:notice] = %[Removed #{@ticket.event.title} from cart. #{link}]

    redirect_to cart_path
  end

  def show
  end

private

  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def link
    view_context.link_to(
      "Undo?",
      cart_path(ticket_id: @ticket.id),
      method: :post
    )
  end
end
