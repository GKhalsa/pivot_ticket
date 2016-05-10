# require "rails_helper"
#
# RSpec.feature "Admin can change the state of an item" do
#   xscenario "Admin can click retire next to an item" do
#     admin = create(:admin)
#
#     ApplicationController.any_instance.stubs(:current_user).returns(admin)
#     create(:item)
#     visit admin_dashboard_path
#
#     expect(Item.last.state).to eq("active")
#
#     click_on "Items"
#     click_on "Retire"
#
#     expect(Item.last.state).to eq("retired")
#   end
#
#   scenario "retired item can not be added to cart" do
#     item = create(:retired_item)
#
#     visit items_path
#
#     expect(page).to have_content(item.title)
#
#     find("a", text: "Item Retired").click
#
#     click_link("shopping_cart")
#     expect(current_path).to eq(cart_path)
#
#     expect(page).not_to have_content(item.title)
#   end
#
#   scenario "admin can reactivate retired item" do
#     admin = create(:admin)
#
#     ApplicationController.any_instance.stubs(:current_user).returns(admin)
#     create(:item)
#
#     Item.last.retired!
#
#     expect(Item.last.state).to eq("retired")
#
#     visit admin_dashboard_path
#
#     click_on "Items"
#     click_on "Activate"
#
#     expect(Item.last.state).to eq("active")
#   end
# end
