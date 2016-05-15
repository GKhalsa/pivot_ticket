require "rails_helper"

RSpec.describe OrderTicket, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:ticket) }
    it { is_expected.to belong_to(:order) }
  end

  describe ".total" do
    it "returns the total of its ticket price and quantity" do
      order_ticket = create(:order_ticket)
      expect(order_ticket.total).to eq(9.99)
    end
  end

  describe ".title" do
    it "returns the title of its ticket" do
      order_ticket = create(:order_ticket)
      expect(order_ticket.ticket.event.title).to eq(order_ticket.ticket.event.title)
    end
  end
end
