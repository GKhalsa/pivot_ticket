# require "rails_helper"
#
# RSpec.feature "User can checkout" do
#   scenario "they see a flash message" do
#     user = create(:user)
#
#     ApplicationController.any_instance.stubs(:current_user).returns(user)
#
#     create_list(:item, 2)
#
#     item_1 = Item.first
#     item_2 = Item.last
#
#     visit items_path
#     within(".card-#{item_1.id}") do
#       click_button("Add to Cart")
#     end
#
#     within(".card-#{item_2.id}") do
#       click_button("Add to Cart")
#     end
#
#     visit cart_path
#
#     click_on "Checkout"
#
#     expect(page).to have_content("Order was successfully placed")
#   end
# end
