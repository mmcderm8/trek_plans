require 'rails_helper'

# Acceptance Criteria:
# * I click "Add a New Activity" on the activities index page
# * I am presented with a form requesting activity name and description
# * I click button "Add Activity"
# * I see my activity on it's own show page
# * On the activities index page, I see my activity added to the list of activities

RSpec.feature "user can create a new activity", %{
  As a registered and authenticated user
  I want to create a new activity
  To share my thoughts
  } do
  scenario "user is not signed in" do

    visit activities_path
    click_link "Add a New Activity"
    expect(page).to have_content "You need to sign in or sign up before continuing"
  end

  scenario "user is signed in and creates a activity successfully" do
    user = FactoryGirl.create(:user)

    visit activities_path
    login_as(user, :scope => :user, :run_callbacks => false)
    click_link "Add a New Activity"
    fill_in "Name", with: "Coffee"
    fill_in "Description", with: "Nectar of the gods"
    attach_file "Image", "#{Rails.root}/spec/fixtures/myfiles/omom.jpg"
    click_button "Submit Activity"

    expect(page).to have_content "Activity added successfully"
    expect(page).to have_content "Coffee"
    expect(page).to have_content "Nectar of the gods"
    expect(page).to have_content user.username

  end

  scenario "user does not enter a name when submitting a activity" do
    user = FactoryGirl.create(:user)

    visit activities_path
    login_as(user, :scope => :user, :run_callbacks => false)
    click_link "Add a New Activity"
    fill_in "Description", with: "Tom loves this breakfast"
    click_button "Submit Activity"

    expect(page).to have_content "Name can't be blank"
  end

  scenario "user does not enter a description when submitting a activity" do
    user = FactoryGirl.create(:user)

    visit activities_path
    login_as(user, :scope => :user, :run_callbacks => false)
    click_link "Add a New Activity"
    fill_in "Name", with: "Pancakes"
    click_button "Submit Activity"

    expect(page).to have_content "Activity added successfully"
    expect(page).to have_content "Pancakes"
    expect(page).to have_content user.username
  end
end
