require "rails_helper"

RSpec.feature "User can add a ticket to their cart" do
  scenario "they see the contents" do

    ticket_1 = create(:ticket)

    ticket_2 = create(:ticket, event_id: ticket_1.event.id, seat_location: "GA")

    visit event_path(ticket_1.event.venue.slug, ticket_1.event.id)

    expect(page).to have_button("Add to Cart")

    within("#ticket-#{ticket_1.id}") do
      click_button("Add to Cart")
    end

    expect(current_path).to eq(event_path(ticket_1.event.venue.slug, ticket_1.event.id))

    click_link("shopping_cart")

    expect(current_path).to eq(cart_path)

    within("table") do
      expect(page).to have_content(ticket_1.event_title)
      expect(page).to have_content(ticket_1.event.date_string)
      expect(page).to have_content(ticket_1.price)
    end
    expect(page).to have_content("Total: 9.99")

    visit event_path(ticket_2.event.venue.slug, ticket_2.event.id)

    within("#ticket-#{ticket_2.id}") do
      click_button("Add to Cart")
    end
    click_link("shopping_cart")

    expect(current_path).to eq(cart_path)

    within("table") do
      expect(page).to have_content(ticket_1.event_title)
      expect(page).to have_content(ticket_1.event.date_string)
      expect(page).to have_content(ticket_1.price)

      expect(page).to have_content(ticket_2.event_title)
      expect(page).to have_content(ticket_2.event.date_string)
      expect(page).to have_content(ticket_2.price)
    end
    expect(page).to have_content("Total: 19.98")
  end
end
