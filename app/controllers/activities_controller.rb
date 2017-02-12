class ActivitiesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @activities = nil;

    if params[:search]
      @activities = Activity.search(params[:search])
      if @activities.empty?
        flash[:notice] = "There are no activities containing the term #{params[:search]}"
      end
    end
  end

  def show
    @id = params[:id]
    @activity = Activity.find(params[:id])
    @reviews = @activity.reviews
  end

  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.new(activity_params)
    @creator = current_user
    @activity.creator = @creator
    if @activity.save
      flash[:notice] = "Activity added successfully"
      redirect_to @activity
    else
      flash[:notice] = @activity.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @activity = Activity.find(params[:id])
    @creator = @activity.creator
    if current_user != @creator
      flash[:notice] = "Sorry, you can't edit somone else's activity!"
      redirect_to @activity
    end
  end

  def update
    @activity = Activity.find(params[:id])
    @creator = @activity.creator
    if @activity.update(activity_params)
      flash[:notice] = "Activity updated successfully"
      redirect_to @activity
    else
      flash[:notice] = @activity.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @activity = Activity.find(params[:id])
    @reviews = @activity.reviews
    if current_user.admin? || (current_user == @activity.creator)
      @activity.destroy
      flash[:notice] = "Activity deleted"
      redirect_to activities_path
    else
      flash[:notice] = "Sorry, you can't delete someone else's activity!"
      render :show
    end
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :description, :creator_id).merge(
      creator: current_user)
  end
end
