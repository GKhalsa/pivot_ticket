require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to have_many(:order_tickets) }
  it { is_expected.to have_many(:tickets) }

  describe ".ordered" do
    it "includes orders with status ordered" do
      ordered_order = create(:order)
      expect(Order.ordered).to include(ordered_order)
    end

    it "excludes orders without status ordered" do
      paid_order = create(:paid_order)
      expect(Order.ordered).not_to include(paid_order)
    end
  end

  describe ".paid" do
    it "includes orders with status paid" do
      paid_order = create(:paid_order)
      expect(Order.paid).to include(paid_order)
    end

    it "excludes orders without status paid" do
      ordered_order = create(:order)
      expect(Order.paid).not_to include(ordered_order)
    end
  end

  describe ".completed" do
    it "includes orders with status completed" do
      completed_order = create(:completed_order)
      expect(Order.completed).to include(completed_order)
    end

    it "excludes orders without status completed" do
      ordered_order = create(:order)
      expect(Order.completed).not_to include(ordered_order)
    end
  end

  describe ".cancelled" do
    it "includes orders with status cancelled" do
      cancelled_order = create(:cancelled_order)
      expect(Order.cancelled).to include(cancelled_order)
    end

    it "excludes orders without status cancelled" do
      ordered_order = create(:order)
      expect(Order.cancelled).not_to include(ordered_order)
    end
  end

  describe ".quantity" do
    it "returns the total quantity of tickets in the order" do
      order = create(:order)
      order.order_tickets.create(quantity: 1)
      order.order_tickets.create(quantity: 2)
      expect(order.quantity).to eq(3)
    end
  end

  describe ".total" do
    it "returns the total dollar amount of the order" do
      order = create(:order)
      order.order_tickets = create_list(:order_ticket, 2)
      expect(order.total).to eq(19.98)
    end
  end

  describe ".cycle_status" do
    it "changes an ordered status to paid" do
      order = create(:order)
      order.cycle_status
      expect(order.status).to eq("paid")
    end

    it "changes a paid status to completed" do
      order = create(:paid_order)
      order.cycle_status
      expect(order.status).to eq("completed")
    end

    it "doesn't change a completed status" do
      order = create(:completed_order)
      order.cycle_status
      expect(order.status).to eq("completed")
    end

    it "doesn't change a cancelled status" do
      order = create(:cancelled_order)
      order.cycle_status
      expect(order.status).to eq("cancelled")
    end
  end

  describe "ordered" do
    it "should return true when asked if status is ordered" do
      order = create(:order)
      expect(order.ordered?).to be(true)
    end

    it "should return false when asked if different status" do
      order = create(:order)
      expect(order.paid?).to be(false)
    end
  end

  describe "paid" do
    it "should return true when asked if paid order" do
      order = create(:paid_order)
      expect(order.paid?).to be(true)
    end

    it "should return false when asked if different status" do
      order = create(:paid_order)
      expect(order.ordered?).to be(false)
    end
  end

  describe "cancelled" do
    it "should return true when asked if cancelled order" do
      order = create(:cancelled_order)
      expect(order.cancelled?).to be(true)
    end

    it "should return false when asked if different status" do
      order = create(:cancelled_order)
      expect(order.ordered?).to be(false)
    end
  end

  describe "completed" do
    it "should return true when asked if completed order" do
      order = create(:completed_order)
      expect(order.completed?).to be(true)
    end

    it "should return false when asked if different status" do
      order = create(:completed_order)
      expect(order.ordered?).to be(false)
    end
  end

  describe ".updated_time" do
    it "should return updated_at formatted nicer" do
      order = create(:order)
      formatted_time = order.updated_at.strftime("%b %e, %l:%M %p")
      expect(order.updated_time).to eq(formatted_time)
    end
  end

  describe ".created_time" do
    it "should return created_at formatted nicer" do
      order = create(:order)
      formatted_time = order.created_at.strftime("%b %e, %l:%M %p")
      expect(order.created_time).to eq(formatted_time)
    end
  end
end
