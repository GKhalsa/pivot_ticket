require "rails_helper"

RSpec.feature "User can view category index" do
  scenario "they see the tickets sorted by category" do
    category_1 = Category.create(name: "Haikus")
    category_2 = Category.create(name: "Limericks")
    event_1 = Event.create(title: "Event1")
    event_2 = Event.create(title: "Event2")
    category_1.tickets.create(seat_location: "Seat 1",
                            # description: "This is the first item",
                            price: 9.99,
                            event_id: event_1.id)
    category_2.tickets.create(seat_location: "Seat 2",
                            # description: "This is the second item",
                            price: 5.99,
                            event_id: event_2.id
                            )

    visit tickets_path
    click_link("Haikus")

    expect(current_path).to eq(category_path(category_1.name))

    expect(page).to have_content("Seat 1")

    expect(page).to have_content("9.99")

    expect(page).not_to have_content("Seat 2")
    expect(page).not_to have_content("5.99")
  end
end
