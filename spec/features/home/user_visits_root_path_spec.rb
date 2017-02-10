require "rails_helper"



feature "user visits root path", %{
  As a visitor
  I want to visit the landing page
  And click "enter" to view the site
} do
    scenario "user visits root path" do
    user = FactoryGirl.create(:user)
    visit root_path

    expect(page).to have_content("enter")

    click_link("enter")

    expect(page).to have_content("Sign In")
  end
end
