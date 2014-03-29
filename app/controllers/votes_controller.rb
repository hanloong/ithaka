class VotesController < ApplicationController
  def create
    @vote = Vote.new(vote_params)
    if @vote.save
      redirect_to project_idea_path(@vote.idea.project, @vote.idea),
                  notice: 'Vote was successfully created.'
    else
      redirect_to project_idea_path(@vote.idea.project, @vote.idea),
                  notice: 'Vote not created.'
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:user_id, :idea_id)
  end
end
