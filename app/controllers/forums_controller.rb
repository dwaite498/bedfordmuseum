class ForumsController < ApplicationController
  def new
    @forum = Forum.new
  end

  def create
    @forum = Forum.new(forum_params)

    if @forum.save
      redirect_to schedule_path
    else
      render 'new'
      flash[:alert] = 'Error creating forum schedule item. Please try again.'
    end
  end

  def edit
    @forum = Forum.find(params[:id])
  end

  def update
    @forum = Forum.find(params[:id])
    @forum.update(forum_params)
    if @forum.update(forum_params)
      redirect_to schedule_path
    else
      render 'edit'
      flash[:alert] = 'Error editing forum schedule item. Please try again.'
    end
  end

  def destroy
    @forum = Forum.find(params[:id])
    unless @forum.destroy
      flash[:alert] = 'Error deleting forum schedule item. Please try again.'
    end
    redirect_to schedule_path
  end

  private

  def forum_params
    params.require(:forum).permit(:date, :text)
  end

  def user_is_admin
    return if current_user && current_user.admin?
    redirect_to articles_path
    flash[:alert] = 'User not authorized'
  end
end
