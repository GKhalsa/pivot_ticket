# require "rails_helper"
#
# RSpec.feature "Admin can login" do
#   scenario "and be taken to the admin dashboard" do
#     admin = create(:admin)
#     visit login_path
#
#     within("#login-form") do
#       fill_in :Email, with: admin.email
#       fill_in :Password, with: "password"
#       click_button("Login")
#     end
#
#     expect(current_path).to eq(admin_dashboard_path)
#     expect(page).to have_content("Admin Dashboard")
#   end
# end
