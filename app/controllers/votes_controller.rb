class VotesController < ApplicationController
  before_action :set_vote, only: [:destroy]

  def create
    voter = VoterService.new(vote_params)
    if voter.place
      @vote = voter.vote
      redirect_to project_idea_path(@vote.idea.project, @vote.idea),
                  notice: 'Vote was successfully created.'
    else
      @vote = voter.vote
      redirect_to project_idea_path(@vote.idea.project, @vote.idea),
                  notice: 'Vote not created.'
    end
  end

  def destroy
    @vote.destroy
    redirect_to project_idea_path(@vote.idea.project, @vote.idea),
                notice: 'Vote Retracted.'
  end

  private

  def set_vote
    @vote = Vote.find(params[:id])
  end

  def vote_params
    params.require(:vote).permit(:user_id, :idea_id)
  end
end
