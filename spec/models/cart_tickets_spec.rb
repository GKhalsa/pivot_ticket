require "rails_helper"

RSpec.describe CartTicket do
  context "when delegating method calls" do
    it "should delegate title call to its ticket" do
      ticket = create(:ticket)
      cart_ticket = CartTicket.new(ticket, 1)
      expect(cart_ticket.event.title).to eq(ticket.event.title)
    end

    it "should delegate description call to its ticket" do
      ticket = create(:ticket)
      cart_ticket = CartTicket.new(ticket, 1)
      expect(cart_ticket.price).to eq(ticket.price)
    end
  end

  describe ".price" do
    it "should return the quantity multiplied by the price of its ticket" do
      ticket = create(:ticket)
      cart_ticket = CartTicket.new(ticket, 2)
      expect(cart_ticket.price).to eq(19.98)
    end
  end
end
