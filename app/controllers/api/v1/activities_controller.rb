class Api::V1::ActivitiesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @activities = Activity.all

    if params[:search]
      @activities = Activity.search(params[:search])
    end

    render json: @activities
  end
end
