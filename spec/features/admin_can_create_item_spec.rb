require "rails_helper"

RSpec.feature "Admin can visit item creation page" do
  scenario "Admin can create an item" do
    user = create(:user)

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit my_tickets_new_path
    fill_in "Seat location", with: "Test Seat"
    fill_in :Category, with: "Music"
    fill_in "Choose an event", with: "Surf Legend Dick Dale!"
    fill_in "Price", with: "201"
    click_button "Create Ticket"

    expect(current_path).to eq(my_tickets_path)
    expect(page).to have_content("Test Seat")
    expect(page).to have_content("201.0")
    expect(page).to have_content("Surf Legend Dick Dale!")
  end

  # scenario "Admin sees error messages when field is left blank" do
  #   admin = create(:admin)
  #
  #   ApplicationController.any_instance.stubs(:current_user).returns(admin)
  #
  #   visit new_admin_item_path
  #   fill_in :Price, with: "5.99"
  #   fill_in :Description, with: "THIS IS AN ITEM"
  #   click_button "Create Item"
  #
  #   expect(page).to have_content("Title can't be blank")
  # end
  #
  # scenario "non admin user visits page and gets 404" do
  #   user = create(:user)
  #
  #   ApplicationController.any_instance.stubs(:current_user).returns(user)
  #
  #   visit new_admin_item_path
  #
  #   expect(page).to have_content("404")
  # end

  scenario "non logged in visitor visits page and gets 404" do
    visit my_tickets_new_path

    expect(current_path).to eq(login_path)
  end
end
