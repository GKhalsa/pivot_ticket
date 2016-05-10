require "rails_helper"

RSpec.feature "User can add a ticket to their cart" do
  scenario "they see the contents" do
    create_list(:ticket, 2)

    ticket_1 = Ticket.first
    ticket_2 = Ticket.last

    visit tickets_path

    expect(page).to have_button("Add to Cart")

    within(".card-#{ticket_1.id}") do
      click_button("Add to Cart")
    end

    expect(current_path).to eq(tickets_path)

    click_link("shopping_cart")

    expect(current_path).to eq(cart_path)

    within("ul.collection:nth-child(1)") do
      expect(page).to have_content(ticket_1.event)
      expect(page).to have_content(ticket_1.event_date)
      expect(page).to have_content(ticket_1.event_venue)
      expect(page).to have_content(ticket_1.seat_location)
      expect(page).to have_content(ticket_1.price)
      # expect(page).to have_content(ticket_1.description)
    end
    expect(page).to have_content("Total: 9.99")

    visit tickets_path

    within(".card-#{ticket_2.id}") do
      click_button("Add to Cart")
    end
    click_link("shopping_cart")

    expect(current_path).to eq(cart_path)
    within("li.collection-ticket:nth-child(1)") do
      expect(page).to have_content(ticket_1.event)
      expect(page).to have_content(ticket_1.event_date)
      expect(page).to have_content(ticket_1.event_venue)
      expect(page).to have_content(ticket_1.seat_location)
      expect(page).to have_content(ticket_1.price)
      # expect(page).to have_content(ticket_1.description)
    end
    within("li.collection-ticket:nth-child(2)") do
      expect(page).to have_content(ticket_2.event)
      expect(page).to have_content(ticket_2.event_date)
      expect(page).to have_content(ticket_2.event_venue)
      expect(page).to have_content(ticket_2.seat_location)
      expect(page).to have_content(ticket_2.price)
      # expect(page).to have_content(ticket_2.description)
    end
    expect(page).to have_content("Total: 19.98")
  end
end
