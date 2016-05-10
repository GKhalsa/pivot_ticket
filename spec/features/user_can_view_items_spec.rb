require "rails_helper"

RSpec.feature "User can view tickets index" do
  scenario "they see all tickets on the page" do
    create_list(:ticket, 2)
    ticket_1 = Ticket.first
    ticket_2 = Ticket.last

    visit tickets_path

    expect(page).to have_content(ticket_1.event)
    expect(page).to have_content(ticket_1.price)

    expect(page).to have_content(ticket_2.event)
    expect(page).to have_content(ticket_2.price)
  end
end
