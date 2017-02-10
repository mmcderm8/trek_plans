require 'rails_helper'

# Acceptance Criteria:
# * I visit a activity show page
# * I see a list of reviews of that activity

feature "user views reviews for a given activity", %{
  As a registered and authenticated user
  I want to view reviews of a activity
  To know whether or not it is worth my time
  } do
  scenario "user sees a list of reviews on the activity's show page" do
    user = FactoryGirl.create(:user)
    activity_1 = FactoryGirl.create(:activity)
    activity_2 = FactoryGirl.create(:activity)
    review_1 = FactoryGirl.create(:review)
    review_2 = FactoryGirl.create(:review, rating: 4)

    visit activity_path(review_1.activity_id)

    expect(page).to have_content review_1.rating
    expect(page).to have_content review_1.body

    expect(page).to_not have_content review_2.body
  end
end
