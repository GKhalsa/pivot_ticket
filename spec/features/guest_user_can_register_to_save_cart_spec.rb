require "rails_helper"

RSpec.feature "User can register an account" do
  scenario "Their cart is saved" do
    ticket_1 = create(:ticket)
    ticket_2 = create(:ticket, event_id: ticket_1.event.id)

    visit event_path(ticket_1.event.venue.slug, ticket_1.event.id)

    within("#ticket-#{ticket_1.id}") do
      click_button("Add to Cart")
    end

    within("#ticket-#{ticket_2.id}") do
      click_button("Add to Cart")
    end

    within(".nav-wrapper") do
      click_link("shopping_cart")
    end

    click_button("Create Account to Checkout")

    within("#create-form") do
      fill_in :Email, with: "user@example.com"
      fill_in :Password, with: "password"
      fill_in "Name", with: "Josh"
      click_button("Create Account")
    end

    within(".nav-wrapper") do
      click_link("shopping_cart")
    end

    expect(page).to have_content("#{ticket_1.event.title}")
    expect(page).to have_content("#{ticket_2.event.title}")
  end
end
