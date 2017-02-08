class Admin::ReviewsController < ApplicationController
  before_action :authenticate_user!, :is_admin?

  def destroy
    @activity = Activity.find(params[:activity_id])
    @review = Review.find(params[:id])

    @review.destroy
    flash[:notice] = "Review deleted"
    redirect_to admin_activity_path(@activity)
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
