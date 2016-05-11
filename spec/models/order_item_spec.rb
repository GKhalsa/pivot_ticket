# require "rails_helper"
#
# RSpec.describe OrderItem, type: :model do
#   describe "associations" do
#     it { is_expected.to belong_to(:item) }
#     it { is_expected.to belong_to(:order) }
#   end
#
#   describe ".total" do
#     it "returns the total of its item price and quantity" do
#       order_item = create(:order_item)
#       expect(order_item.total).to eq(9.99)
#     end
#   end
#
#   describe ".title" do
#     it "returns the title of its item" do
#       order_item = create(:order_item)
#       expect(order_item.title).to eq(order_item.item.title)
#     end
#   end
# end
