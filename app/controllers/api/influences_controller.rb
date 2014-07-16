class Api::InfluencesController < ApplicationController
  before_action :set_idea, only: [:index, :update]
  before_action :set_influence, only: [:update]

  def index
    render json: {score: @idea.score,
                  influence: @idea.influence,
                  votes: @idea.votes_count,
                  influences: @idea.influences.joins(:factor).order('factors.name')}
  end

  def update
    @influence.update(influence_params) if @influence.manager?(current_user)
    render json: {score: @idea.score,
                  influence: @idea.influence,
                  votes: @idea.votes_count}
  end

  private

  def set_influence
    @influence = Influence.find(params[:id])
  end

  def set_idea
    @idea = Idea.find(params[:idea_id])
  end

  def influence_params
    params.require(:influence).permit(:score)
  end
end
