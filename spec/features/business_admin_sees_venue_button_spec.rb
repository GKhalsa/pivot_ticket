require 'rails_helper'

RSpec.describe "Business Admin can see venue button" do
  scenario "admin can click and fill out venue info" do
    role = Role.create(name: "business_admin")
    business_admin = User.create(name: "business admin",
                                email: "email",
                             password: "password")
    business_admin.roles = [role]
    ApplicationController.any_instance.stubs(:current_user).returns(business_admin)
    visit "/"
    expect(page).to have_content("Venue")
    click_on("Venue")
    expect(current_path).to eq(admin_venues_path)
    expect(page).to have_content("Create a New Venue")

    click_on("Create a New Venue")
    fill_in :Name, with: "staples center"
    fill_in :Address, with: "123 fake st"
    click_on("Submit")

    expect(page).to have_content("Your Venue is Pending Approval")
  end

  scenario "Business Admin can see venue once approved" do
    role = Role.create(name: "business_admin")
    venue = Venue.create(name: "staples center", address: "123 st.")
    sports = Category.create(name: "sports")
    event_1, event_2 = create_list(:event, 2, venue_id: venue.id, category_id: sports.id)
    business_admin = User.create(name: "business admin",
                                email: "email",
                             password: "password",
                             venue_id: "#{venue.id}")
    business_admin.roles = [role]

    ApplicationController.any_instance.stubs(:current_user).returns(business_admin)

    visit admin_venue_path(venue: venue.slug)
    expect(page).to have_content("Your Venue is Pending Approval")

    business_admin.venue.update(status: 1)
    visit admin_venue_path(venue: venue.slug)

    expect(page).to have_content("Add Event")
    expect(page).to have_content("Edit Venue")
    expect(page).to have_content("Venue Admin Dashboard")
  end

  context "Business Admin can add an event" do
    scenario "An event is added to the venue show page" do
      role = Role.create(name: "business_admin")
      venue = Venue.create(name: "staples center", address: "123 st.", status: 1)
      sports = Category.create(name: "sports")
      event_1, event_2 = create_list(:event, 2, venue_id: venue.id, category_id: sports.id)
      business_admin = User.create(name: "business admin",
                                  email: "email",
                               password: "password",
                               venue_id: "#{venue.id}")
      business_admin.roles = [role]

      ApplicationController.any_instance.stubs(:current_user).returns(business_admin)

      visit admin_venue_path(venue: venue.slug)
      expect(page).not_to have_content("boogie boogie")
      click_on("Add Event")

      fill_in :Title, with: "boogie boogie"
      fill_in :Performing, with: "woogie woogie"
      fill_in :Date, with: "1/2/3"

      click_on "Submit"
      expect(current_path).to eq(admin_venue_path(venue: venue.slug))
      expect(page).to have_content("boogie boogie")
    end
  end

  scenario "Business Admin can edit events" do
    role = Role.create(name: "business_admin")
    venue = Venue.create(name: "staples center", address: "123 st.", status: 1)
    sports = Category.create(name: "sports")
    event = Event.create(title: "hello",
                    performing: "hello",
                          date: "10/12/17",
                      venue_id: "#{venue.id}",
                   category_id: sports.id)
    business_admin = User.create(name: "business admin",
                                email: "email",
                             password: "password",
                             venue_id: "#{venue.id}")
    business_admin.roles = [role]

    ApplicationController.any_instance.stubs(:current_user).returns(business_admin)

    visit admin_venue_path(venue: venue.slug)

    within(".collapsible-body") do
      click_on("Edit")
    end

    fill_in :Title, with: "what"
    click_on "Submit"
    expect(page).to have_content("what has been updated")
  end

  scenario "Business Admin can delete events" do
    role = Role.create(name: "business_admin")
    venue = Venue.create(name: "staples center", address: "123 st.", status: 1)
    sports = Category.create(name: "sports")
    event_1, event_2 = create_list(:event, 2, venue_id: venue.id, category_id: sports.id)
    event = Event.create(title: "hello",
                    performing: "hello",
                          date: "10/12/17",
                      venue_id: "#{venue.id}"
                        )
    business_admin = User.create(name: "business admin",
                                email: "email",
                             password: "password",
                             venue_id: "#{venue.id}")
    business_admin.roles = [role]

    ApplicationController.any_instance.stubs(:current_user).returns(business_admin)

    visit admin_venue_path(venue: venue.slug)
    expect(page).to have_content("hello")
    expect(Event.count).to eq(3)

    within("#event-#{event.id}") do
      click_on("Delete")
    end

    expect(page).to have_content("hello has been deleted")
    expect(Event.count).to eq(2)
  end


  context "Business Admin can edit the venue" do
    scenario "the venue's name changes" do
      role = Role.create(name: "business_admin")
      venue = Venue.create(name: "staples center", address: "123 st.", status: 1)
      sports = Category.create(name: "sports")
      event_1, event_2 = create_list(:event, 2, venue_id: venue.id, category_id: sports.id)
      business_admin = User.create(name: "business admin",
                                  email: "email",
                               password: "password",
                               venue_id: "#{venue.id}")
      business_admin.roles = [role]

      ApplicationController.any_instance.stubs(:current_user).returns(business_admin)
      visit admin_venue_path(venue: venue.slug)
      expect(page).to have_content("staples center")

      click_on("Edit Venue")
      fill_in :Name, with: "hello"
      fill_in :Address, with: "1234 st."
      click_on("Submit")

      expect(page).to have_content("hello")
    end
  end

  context "Business Admin can add and remove moderators" do
    scenario "the moderators page updates accordingly" do
      role = Role.create(name: "business_admin")
      venue = Venue.create(name: "staples center", address: "123 st.", status: 1)
      sports = Category.create(name: "sports")
      event_1, event_2 = create_list(:event, 2, venue_id: venue.id, category_id: sports.id)
      user = User.create(name: "kaiser soze",
                                  email: "email@email.com",
                               password: "password",
                               venue_id: "#{venue.id}")
      business_admin = User.create(name: "business admin",
                                  email: "email",
                               password: "password",
                               venue_id: "#{venue.id}")
      business_admin.roles = [role]

      ApplicationController.any_instance.stubs(:current_user).returns(business_admin)

      visit admin_venue_path(venue: venue.slug)
      click_on("Venue Admin Dashboard")

      click_on("Create a New Admin")

      fill_in :email, with: "email@email.com"
      click_on("Search")
      click_on("Venue Admin Dashboard")
      expect(page).to have_content("kaiser soze")

      within("#mod-id-#{user.id}") do
        click_on("Remove")
      end

      expect(page).not_to have_content("kaiser soze")
    end
  end
end
