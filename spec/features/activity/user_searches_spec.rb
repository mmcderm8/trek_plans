require 'rails_helper'

# Acceptance Criteria:
# * User can search for a activities
# * If the activity exists in the database, it should show up
# * If the activity does not yet exist in the database, it should not show up
# * If a activity does not match the search criteria, it should not show up
# * if there are no matching activities, an error should appear

RSpec.feature "searchbar", %{
  As a user
  I want to search for a activity
  To see if it is up on the website yet
  } do

  scenario "user searches for a word contained in a activity" do
    activity_1 = FactoryGirl.create(:activity, name: "eggs benedict")
    activity_2 = FactoryGirl.create(:activity, name: "pancakes")

    visit activities_path
    fill_in :search, with: "eggs"
    click_button "Search"

    expect(page).to have_content activity_1.name
    expect(page).to_not have_content activity_2.name
  end

  scenario "user searches for a word not found in activities names" do
    activity = FactoryGirl.create(:activity, name: "eggs benedict")

    visit activities_path
    fill_in :search, with: "french toast"
    click_button "Search"

    expect(page).to_not have_content activity.name
    expect(page).to have_content "There are no activities containing the term french toast"
  end
end
