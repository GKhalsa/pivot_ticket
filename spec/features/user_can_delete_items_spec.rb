require "rails_helper"

RSpec.feature "User can delete an ticket from cart and undo" do
  scenario "they see updated cart" do
    ticket = create(:ticket)

    visit event_path(ticket.event)

    within("#ticket-#{ticket.id}") do
      click_button("Add to Cart")
    end

    visit cart_path

    expect(page).to have_content ticket.event.title
    expect(page).to have_content ticket.price
    click_on "Remove"
    expect(page).to have_content "Removed #{ticket.event.title}"

    expect(page).not_to have_content ticket.price

    click_on "Undo?"

    expect(page).to have_content ticket.event.title
    expect(page).to have_content ticket.price
  end
end
