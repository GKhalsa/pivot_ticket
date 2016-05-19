require 'rails_helper'

RSpec.describe "Admins have control over tickets" do
  scenario "admin creates tickets" do
  end


  context "They have an active ticket that they want to make inactive" do
    scenario "They don't see the ticket on the event show page" do
      user = create(:user)
      role = Role.create(name: "platform_admin")
      user.roles = [role]
      event = create(:event)
      ticket = Ticket.create(price: 201.0,
                     seat_location: "GA",
                           user_id: user.id,
                          event_id: event.id)
      ApplicationController.any_instance.stubs(:current_user).returns(user)

      visit event_path(event.venue.slug, event.id)

      expect(page).to have_content("201.0")
      expect(page).to have_content("GA")

      visit admin_tickets_path
      click_on("de-activate ticket")

      message = "Your ticket to #{event.title} was successfully de-activated"
      # expect(page).to have_content(message)
      # expect(page).to_not have_content("de-activate ticket")
      # expect(page).to have_button("activate ticket")
      #
      # visit events_path
      #
      # expect(page).to_not have_content("201.0")
      # expect(page).to_not have_content("GA")

    end
  end

  context "They have an in-active ticket that they want to make active" do
    scenario "They see the ticket on the event show page" do
      user = create(:user)
      role = Role.create(name: "platform_admin")
      user.roles = [role]
      event = create(:event)
      ticket = Ticket.create(price: 201.0,
                     seat_location: "GA",
                           user_id: user.id,
                          event_id: event.id,
                            status: 1)
      ApplicationController.any_instance.stubs(:current_user).returns(user)

      visit event_path(event.venue.slug, event.id)

      expect(page).to_not have_content("201.0")
      expect(page).to_not have_content("GA")
      visit admin_tickets_path
      click_on("activate ticket")
      message = "Your ticket to #{event.title} was successfully posted for sale"
      # expect(page).to have_content(message)
      # expect(page).to_not have_content("activate ticket")
      # expect(page).to have_button("de-activate ticket")
      # #
      # # visit events_path
      # #
      # # expect(page).to have_content("201.0")
      # # expect(page).to have_content("GA")

    end
  end

  context "They have an expired ticket" do
    scenario "They can't change the status of the expired ticket" do
      user = create(:user)
      role = Role.create(name: "platform_admin")
      user.roles = [role]
      event = create(:event)
      ticket = Ticket.create(price: 201.0,
                     seat_location: "GA",
                           user_id: user.id,
                          event_id: event.id,
                            status: 2)
      ApplicationController.any_instance.stubs(:current_user).returns(user)

      visit event_path(event.venue.slug, event.id)

      expect(page).to_not have_content("201.0")
      expect(page).to_not have_content("GA")

      visit admin_tickets_path

      expect(page).to have_button("ticket is expired")
      expect(page).to_not have_button("activate ticket")
      expect(page).to_not have_button("de-activate ticket")
    end
  end
end
