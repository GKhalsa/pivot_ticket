# require "rails_helper"
#
# RSpec.describe "User can visit category creation page" do
#   scenario "admin can create a category" do
#     admin = create(:admin)
#     ApplicationController.any_instance.stubs(:current_user).returns(admin)
#     visit new_admin_category_path
#
#     fill_in :Name, with: "test category name"
#     click_button "Create Category"
#     expect(page).to have_content("test category name")
#   end
#
#   scenario "admin sees error messages if category field is missing" do
#     admin = create(:admin)
#     ApplicationController.any_instance.stubs(:current_user).returns(admin)
#     visit new_admin_category_path
#
#     click_button "Create Category"
#     expect(page).to have_content("Name can't be blank")
#   end
#
#   scenario "non admin user gets 404" do
#     user = create(:user)
#     ApplicationController.any_instance.stubs(:current_user).returns(user)
#     visit new_admin_category_path
#     expect(page).to have_content("404")
#   end
#
#   scenario "guest user user gets 404" do
#     visit new_admin_category_path
#     expect(page).to have_content("404")
#   end
# end
