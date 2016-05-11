# require "rails_helper"
#
# RSpec.feature "User can update quantity of items in cart" do
#   scenario "they stay on the cart page and see updated quantity of items" do
#     item = create(:item)
#     visit items_path
#
#     within(".card-#{item.id}") do
#       click_button("Add to Cart")
#     end
#
#     visit cart_path
#
#     within("ul.collection:nth-child(1)") do
#       expect(page).to have_content(item.title)
#       expect(page).to have_field("quantity", with: "1")
#       expect(page).to have_content(item.price)
#     end
#     expect(page).to have_content("Total: #{item.price}")
#
#     fill_in("quantity", with: "3")
#     click_button("Update")
#
#     expect(current_path).to eq(cart_path)
#     within("ul.collection:nth-child(1)") do
#       expect(page).to have_content(item.title)
#       expect(page).to have_field("quantity", with: "3")
#       expect(page).to have_content("29.97")
#     end
#     expect(page).to have_content("Total: 29.97")
#
#     fill_in("quantity", with: "2")
#     click_button("Update")
#
#     expect(current_path).to eq(cart_path)
#
#     within("ul.collection:nth-child(1)") do
#       expect(page).to have_content(item.title)
#       expect(page).to have_field("quantity", with: "2")
#       expect(page).to have_content("19.98")
#     end
#     expect(page).to have_content("Total: 19.98")
#   end
# end
