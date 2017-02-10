require 'rails_helper'

RSpec.describe Api::V1::ActivitiesController, type: :controller do
  describe 'GET #index' do
    let(:activity_1) { FactoryGirl.create(:activity) }
    let(:activity_2) { FactoryGirl.create(:activity) }

    let!(:review_1) { FactoryGirl.create(:review, activity: activity_1) }
    let!(:review_2) { FactoryGirl.create(:review, activity: activity_1) }
    let!(:review_3) { FactoryGirl.create(:review, activity: activity_2) }

    let!(:user_1) { FactoryGirl.create(:user) }

    it 'should return all activities and their associated reviews and creators' do
      login_as(user_1)
      get :index
      json = JSON.parse(response.body)

      expect(json.length).to eq(2)
      expect(json[0]["name"]).to eq(activity_1.name)
      expect(json[1]["name"]).to eq(activity_2.name)

      expect(json[0]["reviews"].length).to eq(2)
      expect(json[1]["reviews"].length).to eq(1)

      expect(json[0]["reviews"][0]["id"]).to eq(review_1.id)
      expect(json[0]["reviews"][0]["rating"]).to eq(review_1.rating)
      expect(json[0]["reviews"][0]["body"]).to eq(review_1.body)
    end
  end
end
