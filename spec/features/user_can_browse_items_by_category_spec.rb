# require "rails_helper"
#
# RSpec.feature "User can view category index" do
#   scenario "they see the items sorted by category" do
#     category_1 = Category.create(name: "Haikus")
#     category_2 = Category.create(name: "Limericks")
#     category_1.items.create(title: "Item 1",
#                             description: "This is the first item",
#                             price: 9.99)
#     category_2.items.create(title: "Item 2",
#                             description: "This is the second item",
#                             price: 5.99)
#
#     visit items_path
#     click_link("Haikus")
#
#     expect(current_path).to eq(category_path(category_1.name))
#
#     expect(page).to have_content("Item 1")
#
#     expect(page).to have_content("9.99")
#
#     expect(page).not_to have_content("Item 2")
#     expect(page).not_to have_content("5.99")
#   end
# end
