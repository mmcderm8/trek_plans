require 'rails_helper'

# Acceptance Criteria
#  * Admin has access to an index page of activities
#  * Admin can delete anyone's activity
#  * Admin can delete anyone's review
#  * Non-admin users cannot access these functions

RSpec.feature "admin can see all of the activities", %{
  As an admin,
  I want to delete activities and reviews,
  so that I can get rid of inappropriate ones } do
  scenario "admin views a list of activities" do
    admin = FactoryGirl.create(:user, admin: true)
    activity_1 = FactoryGirl.create(:activity)
    activity_2 = FactoryGirl.create(:activity)

    login_as(admin)
    visit admin_activities_path

    expect(page).to have_content activity_1.name
    expect(page).to have_content activity_2.name
  end

  scenario "admin views a activity show page" do
    admin = FactoryGirl.create(:user, admin: true)
    activity_1 = FactoryGirl.create(:activity)
    activity_2 = FactoryGirl.create(:activity)

    login_as(admin)
    visit admin_activities_path
    click_link activity_1.name

    expect(page).to have_content activity_1.name
    expect(page).to have_content activity_1.description
    expect(page).to have_link "Delete this Activity"

    expect(page).to_not have_content activity_2.name
  end

  scenario "admin deletes a activity" do
    admin = FactoryGirl.create(:user, admin: true)
    activity = FactoryGirl.create(:activity)

    login_as(admin)
    visit admin_activities_path
    click_link activity.name
    click_link "Delete this Activity"

    expect(page).to have_content "Activity deleted"
  end

  scenario "admin deletes a review" do
    admin = FactoryGirl.create(:user, admin: true)
    activity = FactoryGirl.create(:activity)
    review_1 = FactoryGirl.create(:review, activity: activity)

    login_as(admin)
    visit admin_activities_path
    click_link activity.name
    click_link "Delete this Review"

    expect(page).to have_content "Review deleted"
    expect(page).to_not have_content review_1.body
  end

  scenario "non-admin tries to delete a activity that they didn't create" do
    user = FactoryGirl.create(:user)
    user_2 = FactoryGirl.create(:user)
    activity = FactoryGirl.create(:activity, creator: user_2)

    login_as(user)
    visit activity_path(activity)
    click_button "Delete this Activity"

    expect(page).to have_content "Sorry, you can't delete someone else's activity"
  end

  scenario "non-admin tries to delete a review that they didn't write" do
    user = FactoryGirl.create(:user)
    user_2 = FactoryGirl.create(:user)
    activity = FactoryGirl.create(:activity, creator: user_2)
    review = FactoryGirl.create(:review, activity: activity, reviewer: user)

    login_as(user_2)
    visit activity_path(activity)
    click_button "Delete this Review"

    expect(page).to have_content "Sorry, you can't delete someone else's review"
  end
end
