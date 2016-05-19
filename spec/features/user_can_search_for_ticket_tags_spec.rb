require "rails_helper"

RSpec.feature "User can search for tickets by tags" do
  scenario "no search is entered" do
    visit tickets_path

    expect(page).to have_content("No tickets match your query.")
  end
end
