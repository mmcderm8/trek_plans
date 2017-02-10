require "rails_helper"

RSpec.feature "activity creator gets emails when activity is reviewed" do
  scenario "someone reviews a activity" do
    activity = FactoryGirl.create(:activity)
    creator = activity.creator

    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user, :run_callbacks => false)

    visit activity_path(activity)
    click_button "Review this Activity"
    fill_in "Rating", with: "4"
    fill_in "Comments", with: "This activity is pretty rad"
    click_button "Review #{activity.name}"

    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end
end
