require "rails_helper"

RSpec.feature "User can view items index" do
  scenario "they see all items on the page" do
    create_items

    visit items_path

    expect(page).to have_content("Item 1")
    expect(page).to have_content("9.99")
    expect(page).to have_css("img[src=\"/images/example.image\"]")

    expect(page).to have_content("Item 2")
    expect(page).to have_content("5.99")
    expect(page).to have_css("img[src=\"/images/example.image/2\"]")
  end
end