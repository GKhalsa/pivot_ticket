require 'rails_helper'

RSpec.feature "User sees events by venue" do
  context "They visit the venue's event page" do
    scenario "They only see the events of that venue" do
      venue_1, venue_2 = create_list(:venue, 2)
      event_1, event_2 = create_list(:event, 2, venue_id: venue_1.id)
      event_3 = create(:event, venue_id: venue_2.id)

      visit root_path

      click_on venue_1.name

      expect(current_path).to eq('/venue-1-name/events')

      expect(page).to have_content(venue_1.name)
      expect(page).to have_content(event_1.name)
      expect(page).to have_content(event_2.name)
      expect(page).to_not have_content(event_3.name)
    end
  end
end
