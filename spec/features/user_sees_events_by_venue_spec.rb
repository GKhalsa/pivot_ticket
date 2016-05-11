require 'rails_helper'

RSpec.feature "User sees events by venue" do
  context "They visit the venue's event page" do
    scenario "They only see the events of that venue" do
      venue_1, venue_2 = create_list(:venue, 2)

      visit root_path


      # I should see links to tickets sorted by venue.
      # when I click on a venue, I should be directed to an
      # index of tickets to that venue, and not see any
      # tickets to other venues.
    end
  end
end
