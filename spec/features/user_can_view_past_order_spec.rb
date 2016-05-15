require "rails_helper"

RSpec.feature "User can view past order" do
  scenario "They can click and see invoice breakdown" do
    order_ticket = create(:order_ticket)
    order = order_ticket.order
    user = order.user

    role = Role.create(name: "registered_user")

    user.roles = [role]

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit orders_path

    click_on order.id
    expect(page).to have_content order.tickets.first.price
    expect(page).to have_content "Status: ordered"
  end
end
