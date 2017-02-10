require 'rails_helper'

# Acceptance Criteria:
# * User can edit their own reviews
# * User cannot edit others' reviews

RSpec.feature "user can edit reviews", %{
  As a user
  I want to edit my reviews
  So I can fix my typos or changed opinions
 } do
   scenario "user edits a review they created" do
     user = FactoryGirl.create(:user)
     activity = FactoryGirl.create(:activity)
     review = FactoryGirl.create(:review, activity: activity, reviewer: user)

     login_as(user)
     visit activity_path(activity)
     click_button "Edit this Review"
     fill_in "Rating", with: 4
     fill_in "Comments", with: "it's pretty good"
     click_button "Review #{activity.name}"

     expect(page).to have_content "it's pretty good"
   end

   scenario "user tries to edit a review they did not create" do
    user = FactoryGirl.create(:user)
    user_2 = FactoryGirl.create(:user)
    activity = FactoryGirl.create(:activity)
    review = FactoryGirl.create(:review, activity: activity, reviewer: user)

    login_as(user_2)
    visit activity_path(activity)
    click_button "Edit this Review"

    expect(page).to have_content "Sorry, you can't edit someone else's review!"
   end
 end
