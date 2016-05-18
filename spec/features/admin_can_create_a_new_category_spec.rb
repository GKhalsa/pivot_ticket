require "rails_helper"

RSpec.describe "User can visit category creation page" do
  scenario "admin can create a category" do
    role = Role.create(name: "platform_admin")
    platform_admin = User.create(name: "Platform Admin",
                                email: "email",
                             password: "password")
    platform_admin.roles = [role]
    venue = Venue.create(name: "staples center", address: "123 fake st.")
    platform_admin.update(venue_id: venue.id)

    ApplicationController.any_instance.stubs(:current_user).returns(platform_admin)
    visit new_admin_category_path

    fill_in :Name, with: "test category name"
    click_button "Create Category"
    expect(page).to have_content("test category name")
  end

  scenario "admin sees error messages if category field is missing" do
    role = Role.create(name: "platform_admin")
    platform_admin = User.create(name: "Platform Admin",
                                email: "email",
                             password: "password")
    platform_admin.roles = [role]
    ApplicationController.any_instance.stubs(:current_user).returns(platform_admin)
    visit new_admin_category_path

    click_button "Create Category"
    expect(page).to have_content("Name can't be blank")
  end

  scenario "non admin user gets redirected to root" do
    role = Role.create(name: "registered_user")
    registered_user = User.create(name: "Registered User",
                                 email: "email",
                              password: "password")
    registered_user.roles = [role]
    ApplicationController.any_instance.stubs(:current_user).returns(registered_user)
    visit new_admin_category_path
    expect(page).to have_content("404")
  end

  scenario "guest user gets redirected to root" do
    visit new_admin_category_path
    expect(page).to have_content("404")
  end
end
