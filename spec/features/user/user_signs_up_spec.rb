require "rails_helper"

# Acceptance Criteria:
# * I click "Sign Up" on the activities index page
# * I am presented with a form
# * I must submit valid username, email, password and a photo
# * I will be prompted to enter correct information if I enter invalid information
# * I will click "Sign up"
# * I will be redirected to the activities index page

feature "user registers", %{
  As an unregistered user
  I want to register
  So that I can create an account
} do

  scenario "provide valid registration information" do
    visit new_user_registration_path

    fill_in "Email", with: "matt12345@example.com"
    fill_in "user_password", with: "password12345"
    fill_in "user_password_confirmation", with: "password12345"
    fill_in "Username", with: "matt12345"

    click_button "Sign up"
    user = User.last

    expect(page).to have_content("Welcome! You have signed up successfully.")
    expect(page).to have_content("Sign Out")
  end

  scenario "provide invalid registration information" do
    visit new_user_registration_path

    click_button "Sign up"

    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content("Sign Out")
  end

  scenario 'user uploads profile photo' do
    visit new_user_registration_path

    fill_in "Email", with: "matt12345@example.com"
    fill_in "user_password", with: "password12345"
    fill_in "user_password_confirmation", with: "password12345"
    fill_in "Username", with: "matt12345"
    attach_file "Avatar", "#{Rails.root}/spec/fixtures/myfiles/pizza_party.png"

    click_button "Sign up"
    click_link "matt12345@example.com"
    click_button "Edit my account!"

    expect(page).to have_css("img[src*='pizza_party.png']")
  end
end
