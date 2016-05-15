require "rails_helper"

RSpec.describe OrderBuilder do
  describe ".create" do
    it "creates orders out of tickets in the cart" do
      order = create(:order)
      ticket = create(:ticket)
      cart = Cart.new(ticket.id => ticket.id)
      order_builder = OrderBuilder.new(cart, order)
      order_builder.create
      expect(order.tickets.last).to eq(ticket)
    end

    it "attaches the order to the current user" do
      order = create(:order)
      user = order.user
      ticket = create(:ticket, user_id: user.id)
      cart = Cart.new(ticket.id => ticket.id)
      order_builder = OrderBuilder.new(cart, order)
      order_builder.create
      expect(user.tickets.last).to eq(ticket)
    end
  end
end
