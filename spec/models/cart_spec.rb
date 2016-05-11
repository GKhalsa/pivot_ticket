require "rails_helper"

RSpec.describe "Cart" do
  it "has initial contents" do
    cart = Cart.new("1" => 1)

    expect(cart.contents).to eq("1" => 1)
  end

  describe ".add_ticket" do
    it "can add an ticket" do
      cart = Cart.new(nil)
      cart.add_ticket(1)
      expect(cart.contents).to eq("1" => 1)
    end
  end

  describe ".total" do
    it "returns the total price of all tickets" do
      ticket = create(:ticket)
      cart = Cart.new(ticket.id => 1)
      expect(cart.total).to eq(9.99)
    end
  end

  describe ".all_tickets" do
    it "returns an array of cart tickets for each ticket" do
      ticket = create(:ticket)
      cart = Cart.new(ticket.id => 1)
      expect(cart.all_tickets.first.class).to eq(CartTicket)
    end
  end

  describe ".delete_ticket" do
    it "deletes an ticket from the cart" do
      ticket = create(:ticket)
      cart = Cart.new(ticket.id.to_s => 1)
      cart.delete_ticket(ticket.id)
      expect(cart.contents).to eq({})
    end
  end

  describe ".updated_ticket" do
    it "updated the quantity of an ticket in the cart" do
      ticket = create(:ticket)
      cart = Cart.new(ticket.id.to_s => 1)
      cart.update_ticket(ticket.id, 2)
      expect(cart.contents).to eq(ticket.id.to_s => 2)
    end
  end
end
