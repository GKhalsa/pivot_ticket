require 'rails_helper'

RSpec.feature "User sees events by venue" do
  context "They visit the venue's event page" do
    scenario "They only see the events of that venue" do
      venue_1, venue_2 = create_list(:venue, 2)
      sports = Category.create(name: "sports")
      event_1, event_2 = create_list(:event, 2, venue_id: venue_1.id, category_id: sports.id)
      event_3 = create(:event, venue_id: venue_2.id, category_id: sports.id)
      event_1.tickets.create(seat_location: "GA", price: 10)
      event_2.tickets.create(seat_location: "GA", price: 10)
      event_3.tickets.create(seat_location: "GA", price: 10)

      venue_1.update(status: 1)
      visit root_path
      click_on venue_1.name

      correct_path = "/#{venue_1.name.parameterize}/events"

      expect(current_path).to eq(correct_path)

      expect(page).to have_content(venue_1.name)
      expect(page).to have_content(event_1.title)
      expect(page).to have_content(event_2.title)
      expect(page).to_not have_content(event_3.title)
    end
  end
end
