require 'rails_helper'

RSpec.feature "Admin can change a venue's status" do
  context "a platform admin clicks to change a venue's status from active to inactive" do
    scenario "The venue is no longer visible to viewers" do
      admin = User.create!(name: "Platform_admin",
                          email: "platform_admin@example.com",
                       password: "password")
      admin.roles.create!(name: "platform_admin")

      Venue.create!(name: "venue_name",
                 address: "venue_address",
                  status: 1)
      ApplicationController.any_instance.stubs(:current_user).returns(admin)

      visit root_path

      expect(page).to have_content("venue_name")

      visit admin_dashboard_path

        expect(page).to_not have_button('de-activate venue')

        find(:css, "#venue_name-de-activate").click

        # click_on 'activate venue'


      expect(page).to have_content("venue_name was successfully de-activated")

      visit root_path

      expect(page).to_not have_content("venue_name")
    end
  end

  context "a platform admin clicks to change a venue's status from inactive to active" do
    scenario "The venue starts invisible and becomes visible" do
      admin = User.create(name: "Platform_admin",
                         email: "platform_admin@example.com",
                      password: "password" )
      admin.roles.create(name: "platform_admin")

      Venue.create!(name: "venue_name",
                address: "venue_address",
                 status: 2)

      ApplicationController.any_instance.stubs(:current_user).returns(admin)

      visit root_path

      expect(page).to_not have_content("venue_name")

      visit admin_dashboard_path


        expect(page).to_not have_button('activate venue')
        find(:css, "#venue_name-activate").click
        # click_on 'de-activate venue'


      expect(page).to have_content("venue_name was successfully activated")

      visit root_path

      expect(page).to have_content("venue_name")
    end
  end
end
