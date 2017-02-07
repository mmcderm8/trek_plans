class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def new
    @review = Review.new
    @activity = Activity.find(params[:activity_id])
  end

  def create
    @activity = Activity.find(params[:activity_id])
    @reviewer = current_user
    @review = Review.new(review_params)
    @review.reviewer_id = @reviewer.id
    if @review.save
      UserMailer.new_review(@review).deliver_now
      flash[:notice] = "Review added successfully"
      redirect_to activity_path(@activity)
    else
      flash[:notice] = @review.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
    @activity = @review.activity
    @reviewer = @review.reviewer
    if current_user != @reviewer
      flash[:notice] = "Sorry, you can't edit someone else's review!"
      redirect_to @activity
    end
  end

  def update
    @review = Review.find(params[:id])
    @activity = @review.activity
    @reviewer = @review.reviewer
    if @review.update(review_params)
      flash[:notice] = "Review updated successfully"
      redirect_to @activity
    else
      flash[:notice] = @review.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @activity = Activity.find(params[:activity_id])
    @review = Review.find(params[:id])
    if current_user.admin? || (current_user == @review.reviewer)
      @review.destroy
      flash[:notice] = "Review deleted"
    else
      flash[:notice] = "Sorry, you can't delete someone else's review!"
    end
    redirect_to activity_path(@activity)
  end

  private

  def review_params
    params.require(:review).permit(
      :rating,
      :body,
      :reviewer_id,
      :activity_id,
      :upvote_count,
      :downvote_count,
      :sum_votes,
      :votes
    ).merge(
      activity: Activity.find(params[:activity_id]),
      reviewer: current_user
    )
  end
end
