class VotesController < ApplicationController

  #vote status true or false
  #intermediary table

  def new
    @vote = Vote.new
  end

  def voted?
    #if vote has this work connected with this user id exists
    Vote.exists? work_id: params[:work_id].to_i, user_id: @current_user.id
  end

  def create
    if @current_user && voted?
      flash[:error] = "Sorry, you can only vote for a work once."
      redirect_back fallback_location: root_path
    elsif @current_user
      new_vote = {work_id: params[:work_id].to_i, user_id: @current_user.id}
      @vote = Vote.new(new_vote)
        if @vote.save!
          flash[:success] = "You have voted!"
          redirect_to root_path
        else
          # raise
          flash[:error] = "Sorry, your vote wasn't cast. Please try again."
          redirect_back fallback_location: root_path
        end
    else
      flash[:warning] = "You must be logged in to vote"
      redirect_back fallback_location: root_path #go to same page or go to home
    end
  end

  private

  def vote_params
    return params.permit(:id, :work_id, user_id: [])
  end
end
