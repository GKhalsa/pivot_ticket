require "rails_helper"

RSpec.feature "User can checkout" do
  scenario "they see a flash message" do
    user = create(:user)

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    create_list(:ticket, 2)

    ticket_1 = Ticket.first
    ticket_2 = Ticket.last

    visit tickets_path
    within(".card-#{ticket_1.id}") do
      click_button("Add to Cart")
    end

    within(".card-#{ticket_2.id}") do
      click_button("Add to Cart")
    end

    visit cart_path

    click_on "Checkout"

    expect(page).to have_content("Order was successfully placed")
  end
end
