require "rails_helper"

RSpec.feature "User can visit admin dashboard" do
  scenario "Admin can see admin dashboard" do
    admin = create(:admin)
    role = Role.create(name: "platform_admin")
    admin.roles = [role]
    
    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_dashboard_path

    expect(page).to have_content("Admin Dashboard")
  end

  scenario "registered non admin user sees 404" do
    user = create(:user)

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit admin_dashboard_path

    expect(page).to have_content("404")
    expect(page).not_to have_content("Admin Dashboard")
  end

  scenario "non registered user sees 404" do
    visit admin_dashboard_path

    expect(page).to have_content("404")
    expect(page).not_to have_content("Admin Dashboard")
  end
end
