require "rails_helper"

RSpec.feature "User can view category index" do
  scenario "they see the events sorted by category" do
    category_1 = Category.create(name: "Haikus")
    category_2 = Category.create(name: "Limericks")
    venue = Venue.create(name: "venue")
    event_1 = Event.create(title: "Haiku Event",
                            date: Date.today,
                     category_id: category_1.id,
                        venue_id: venue.id)
    event_2 = Event.create(title: "Limericks Event",
                            date: Date.today,
                     category_id: category_2.id,
                        venue_id: venue.id)
    event_1.tickets.create(seat_location: "GA", price: 10)
    event_2.tickets.create(seat_location: "GA", price: 10)

    visit events_path
    click_link("Haikus")

    expect(current_path).to eq(category_path(category_1.name))

    within('.events') do
      expect(page).to have_content("Haiku Event")
      expect(page).not_to have_content("Limericks Event")
    end

  end
end
