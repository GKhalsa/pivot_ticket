require "rails_helper"

RSpec.describe CartItems do
  context "when delegating method calls" do
    it "should delegate title call to its item" do
      item = create(:item)
      cart_item = CartItems.new(item, 1)
      expect(cart_item.title).to eq(item.title)
    end

    it "should delegate description call to its item" do
      item = create(:item)
      cart_item = CartItems.new(item, 1)
      expect(cart_item.description).to eq(item.description)
    end
  end

  describe ".price" do
    it "should return the quantity multiplied by the price of its item" do
      item = create(:item)
      cart_item = CartItems.new(item, 2)
      expect(cart_item.price).to eq(19.98)
    end
  end
end
