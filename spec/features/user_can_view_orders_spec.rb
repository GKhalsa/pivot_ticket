require "rails_helper"

RSpec.feature "User can view orders" do
  scenario "they see an order breakdown" do
    user = create(:user)

    role = Role.create(name: "registered_user")

    user.roles = [role]

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    ticket_1 = create(:ticket)

    ticket_2 = create(:ticket, event_id: ticket_1.event.id)

    visit event_path(ticket_1.event)

    within("#ticket-#{ticket_1.id}") do
      click_button("Add to Cart")
    end


    within("#ticket-#{ticket_2.id}") do
      click_button("Add to Cart")
    end

    visit cart_path
    click_on "Checkout"

    order = Order.first
    expect(page).to have_content("Your Orders")
    expect(page).to have_content(order.created_time)
  end

  context "users cannot view other users orders" do
    scenario "when they visit their order page" do
      order = create(:order)
      user = create(:user)

      ApplicationController.any_instance.stubs(:current_user).returns(user)

      visit orders_path

      expect(page).not_to have_content(order.id)
      expect(page).not_to have_content(order.total)
    end

    scenario "when they try to visit the order directly" do
      order = create(:order)

      user = create(:user)
      ApplicationController.any_instance.stubs(:current_user).returns(user)

      expect(page).to have_content("404")
    end
  end

  context "unregistered user cannot view orders" do
    scenario "is redirected to login when trying to view index" do
      create(:order)

      visit orders_path

      expect(page).to have_content("404")
    end

    scenario "is redirected to login path when trying to view specific order" do
      order = create(:order)

      visit order_path(order)

      expect(page).to have_content("404")

    end
  end
end
