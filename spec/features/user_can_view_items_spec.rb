require "rails_helper"

RSpec.feature "User can view tickets index" do
  scenario "they see all tickets on the page" do
    ticket_1 = create(:ticket)
    ticket_2 = create(:ticket, event_id: ticket_1.event.id )

    visit event_path(ticket_1.event.id)

    expect(page).to have_content(ticket_1.price)

    expect(page).to have_content(ticket_2.price)
  end
end
