class OrderBuilder
  attr_reader :cart, :current_user, :order

  def initialize(cart, order)
    @order = order
    @cart = cart
  end

  def create
    build_order_tickets_for_order
    order.save
  end

  def build_order_tickets_for_order
    cart.contents.each do |ticket_id, quantity|
      order.order_tickets.create(
        ticket_id: ticket_id,
        quantity: quantity,
      )
    end
  end
end
