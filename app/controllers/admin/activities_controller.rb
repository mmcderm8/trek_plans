class Admin::ActivitiesController < ApplicationController
  before_action :authenticate_user!, :is_admin?

  def index
    @activities = Activity.all

    if params[:search]
      @activities = Activity.search(params[:search])
      if @activities.empty?
        flash[:notice] = "There are no activities containing the term #{params[:search]}"
      end
    end
  end

  def show
    @activity = Activity.find(params[:id])
    @reviews = @activity.reviews
  end

  def destroy
    @activity = Activity.find(params[:id])

    @activity.destroy
    flash[:notice] = "Activity deleted"
    redirect_to admin_activities_path
  end

  private

  def is_admin?
    if current_user.admin?
      true
    else
      flash[:notice] = "Sorry, you don't have access to that feature!"
    end
  end
end
