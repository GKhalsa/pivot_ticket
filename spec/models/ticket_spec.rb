# require "rails_helper"
#
# RSpec.describe Ticket, type: :model do
#   describe "validations" do
#     it { is_expected.to validate_presence_of(:title) }
#     it { is_expected.to validate_presence_of(:description) }
#     it { is_expected.to validate_presence_of(:price) }
#     it { is_expected.to validate_uniqueness_of(:title) }
#   end
#
#   describe "self.all_by_state" do
#     it "returns all items ordered by state " do
#       order_1 = create(:item)
#       order_2 = create(:retired_item)
#
#       expect(Item.all_by_state).to eq([order_1, order_2])
#     end
#   end
#
#   describe "self.all_by_id" do
#     it "returns all items ordered by id" do
#       list = create_list(:item, 2)
#       expect(Item.all_by_id).to eq(list)
#     end
#   end
# end
