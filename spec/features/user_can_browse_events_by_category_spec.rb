require "rails_helper"

RSpec.feature "User can view category index" do
  scenario "they see the tickets sorted by category" do
    category_1 = Category.create(name: "Haikus")
    category_2 = Category.create(name: "Limericks")
    Event.create(title: "Haiku Event", category_id: category_1.id)
    Event.create(title: "Limericks Event", category_id: category_2.id)

    visit events_path
    click_link("Haikus")

    expect(current_path).to eq(category_path(category_1.name))

    within('.events') do
      expect(page).to have_content("Haiku Event")
      expect(page).not_to have_content("Limericks Event")
    end

  end
end
