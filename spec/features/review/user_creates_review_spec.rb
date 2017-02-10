require 'rails_helper'

# Acceptance Criteria:
# * I visit a activities show page
# * I see a button "Add a Review"
# * I click "Add a Review"
# * I am presented with a form requesting a rating and review
# * If I enter invalid information, I will receive a prompt to enter correct information
# * If I enter valid information and click "Add Review", I am redirected to the activities show page
# * I see my review under the activities

RSpec.feature "user can create a new review", %{
  As a registered and authenticated user
  I want to create a review
  To share my thoughts about a particular activities
  } do
  scenario "user is not signed in" do
    user = FactoryGirl.create(:user)
    activities = FactoryGirl.create(:activities)

    logout(:user)
    visit activities_path(activities)
    click_button "Review this Activity"
    expect(page).to have_content "You need to sign in or sign up before continuing"
  end

  scenario "user is signed in and creates a review successfully" do
    user = FactoryGirl.create(:user)
    activities = FactoryGirl.create(:activities)

    visit activities_path(activities)
    login_as(user, :scope => :user, :run_callbacks => false)
    click_button "Review this Activity"
    fill_in "Rating", with: "4"
    fill_in "Comments", with: "This place is pretty rad"
    click_button "Review #{activities.name}"

    expect(page).to have_content "Review added successfully"
    expect(page).to have_content "4"
    expect(page).to have_content "This place is pretty rad"
    expect(page).to have_content user.username
  end

  scenario "user does not enter a rating when submitting a review" do
    user = FactoryGirl.create(:user)
    activities = FactoryGirl.create(:activities)

    visit activities_path(activities)
    login_as(user, :scope => :user, :run_callbacks => false)
    click_button "Review this Activity"
    fill_in "Comments", with: "I love this for breakfast!"
    click_button "Review #{activities.name}"

    expect(page).to have_content "Rating can't be blank"
  end

  scenario "user does not enter a body when submitting a review" do
    user = FactoryGirl.create(:user)
    activities = FactoryGirl.create(:activities)

    visit activities_path(activities)
    login_as(user, :scope => :user, :run_callbacks => false)
    click_button "Review this Activity"
    fill_in "Rating", with: "5"
    click_button "Review #{activities.name}"

    expect(page).to have_content "Review added successfully"
    expect(page).to have_content "5"
    expect(page).to have_content user.username
  end
end
