require 'rails_helper'

# Acceptance Criteria:
# * User can edit their own activities
# * User cannot edit others' activities

RSpec.feature "user can edit activities", %{
  As a user
  I want to edit my activities
  So I can fix my typos
 } do
   scenario "user edits a activity they created" do
    user = FactoryGirl.create(:user)
    activity = FactoryGirl.create(:activity, creator: user)

    login_as(user)
    visit activity_path(activity)
    click_button "Edit this Activity"
    fill_in "Name", with: "french toast"
    fill_in "Description", with: "sometimes dry"
    click_button "Submit Activity"

    expect(page).to have_content "french toast"
    expect(page).to have_content "sometimes dry"
   end

   scenario "user tries to edit a activity they did not create" do
    user = FactoryGirl.create(:user)
    user_2 = FactoryGirl.create(:user)
    activity = FactoryGirl.create(:activity, creator: user)

    login_as(user_2)
    visit activity_path(activity)
    click_button "Edit this Activity"

    expect(page).to have_content "Sorry, you can't edit somone else's activity!"
   end
 end
