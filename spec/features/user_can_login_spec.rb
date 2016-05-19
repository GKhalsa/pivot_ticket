require "rails_helper"

RSpec.feature "Visitor can visit login page" do
  scenario "click on create account and see the form to create an account" do
    visit root_path
    within(".nav-wrapper") do
      expect(page).to have_content("Login")
    end

    click_link("Login")

    expect(current_path).to eq(login_path)

    within("#login-form") do
      expect(page).to have_content("Email")
      expect(page).to have_content("Password")
      expect(page).to have_button("Login")
    end

    within("#create-form") do
      expect(page).to have_button("Create Account")
    end
  end

  scenario "User can create an account" do
    visit login_path
    within("#create-form") do
      fill_in :Email, with: "user@example.com"
      fill_in :Password, with: "password"
      fill_in "Name", with: "Josh"
    end
    within("#create-form") do
      click_button("Create Account")
    end

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Account successfully created")
    within(".nav-wrapper") do
      expect(page).to have_content("Logout")
      expect(page).not_to have_content("Login")
    end
  end

  scenario "user updates account" do
    visit login_path
    within("#create-form") do
      fill_in :Email, with: "user@example.com"
      fill_in :Password, with: "password"
      fill_in "Name", with: "Josh"
    end
    within("#create-form") do
      click_button("Create Account")
    end

    click_link("Update My Account")

    click_button("Update Account")
  end
end
