require "rails_helper"

RSpec.feature "User can checkout" do
  scenario "they see a flash message" do
    user = create(:user)

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    ticket_1 = create(:ticket)
    ticket_2 = create(:ticket, event_id: ticket_1.event.id)

    visit event_path(ticket_1.event.venue.slug, ticket_1.event.id)

    within("#ticket-#{ticket_1.id}") do
      click_button("Add to Cart")
    end

    within("#ticket-#{ticket_2.id}") do
      click_button("Add to Cart")
    end

    visit cart_path

    click_on "Checkout"

    expect(page).to have_content("Order was successfully placed")
  end
end
