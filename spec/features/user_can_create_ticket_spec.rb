require "rails_helper"

RSpec.feature "User can visit ticket creation page" do
  scenario "User can create an ticket" do
    user = create(:user)
    role = Role.create(name: "registered_user")
    user.roles = [role]
    event = create(:event)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit my_tickets_new_path
    fill_in "Seat location", with: "Test Seat"
    fill_in "Price", with: "201"
    click_button "Create Ticket"

    expect(page).to have_content("Test Seat")
    expect(page).to have_content("201.0")
    expect(page).to have_button("de-activate ticket")
  end
end
