require "rails_helper"

# Acceptance Criteria:
# * On my user account page, I see an "Edit my account!" button
# * If I click "Edit my account!", I am redirected to an edit page
# * I can enter new valid information
# * If I enter valid information, I am allowed to save
# * I see new information reflected on my account page

feature "user edits account", %{
  As a registered and unauthenticated user
  I want to edit my account
  So I can keep my account up to date
} do

  scenario "edit account" do
    visit new_user_registration_path

    fill_in "Email", with: "matt12345@example.com"
    fill_in "user_password", with: "password12345"
    fill_in "user_password_confirmation", with: "password12345"
    fill_in "Username", with: "matt12345"

    click_button "Sign up"
    user = User.last

    click_link "matt12345@example.com"

    click_button "Edit my account!"
    user = User.last

    fill_in "Email", with: "matt54321@example.com"
    fill_in "current_password", with: "password12345"

    click_button "Update"

    expect(page).to have_content("Your account has been updated successfully.")
  end
end
