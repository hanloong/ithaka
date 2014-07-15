class Api::InfluencesController < ApplicationController
  before_action :set_influence, only: [:update, :show]

  def show
    render json: {score: @influence.idea.score,
                  influence: @influence.idea.influence}
  end

  def update
    @influence.update(influence_params) if @influence.manager?(current_user)
    render json: {score: @influence.idea.score,
                  influence: @influence.idea.influence}
  end

  private

  def set_influence
    @influence = Influence.find(params[:id])
  end

  def influence_params
    params.require(:influence).permit(:score)
  end
end
