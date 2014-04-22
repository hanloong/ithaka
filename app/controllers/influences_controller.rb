class InfluencesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_influence

  def update
    @influence.update(influence_params) if @influence.manager?(current_user)
  end

  private

  def set_influence
    @influence = Influence.find(params[:id])
  end

  def influence_params
    params.require(:influence).permit(:score)
  end
end
