require "rails_helper"

RSpec.feature "User can logout" do
  scenario "He sees the login link and an empty cart" do
    user = create(:user)
    ticket = create(:ticket)

    visit login_path

    within("#login-form") do
      fill_in :Email, with: user.email
      fill_in :Password, with: user.password
      click_button("Login")
    end

    visit event_path(ticket.event.id)

    within("#ticket-#{ticket.id}") do
      click_button("Add to Cart")
    end

    click_link("Logout")

    expect(page).to have_content("Login")
    expect(page).not_to have_content("Logout")

    within(".nav-wrapper") do
      click_link("shopping_cart")
    end

    expect(page).not_to have_content("#{ticket.event.title}")
  end
end
