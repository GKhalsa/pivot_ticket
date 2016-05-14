require "rails_helper"

RSpec.feature "Admin can visit item creation page" do
  scenario "Admin can create an item" do
    user = create(:user)

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit new_ticket_path
    fill_in :Title, with: "Test Item"
    fill_in :Price, with: "5.99"
    fill_in :Description, with: "THIS IS AN ITEM"
    attach_file "File", "spec/asset_specs/photos/photo.jpg"
    attach_file "Avatar", "spec/asset_specs/photos/photo.jpg"
    click_button "Create Item"

    expect(current_path).to eq(admin_items_path)
    expect(page).to have_content("Test Item")
    expect(page).to have_content("5.99")
  end

  scenario "Admin sees error messages when field is left blank" do
    admin = create(:admin)

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit new_admin_item_path
    fill_in :Price, with: "5.99"
    fill_in :Description, with: "THIS IS AN ITEM"
    attach_file "File", "spec/asset_specs/photos/photo.jpg"
    attach_file "Avatar", "spec/asset_specs/photos/photo.jpg"
    click_button "Create Item"

    expect(page).to have_content("Title can't be blank")
  end

  scenario "non admin user visits page and gets 404" do
    user = create(:user)

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit new_admin_item_path

    expect(page).to have_content("404")
  end

  scenario "non logged in visitor visits page and gets 404" do
    visit new_admin_item_path

    expect(page).to have_content("404")
  end
end
