class FactorsController < ApplicationController
  before_action :set_project
  before_action :set_factor, only: [:update, :destroy]

  def index
    @factors = @project.factors
  end

  def create
    if Factor.create factor_params.merge(project: @project)
      redirect_to project_factors_path(@project), notice: 'Factor created'
    else
      redirect_to project_factors_path(@project), error: 'Oops, something went wrong'
    end

  end

  def update
    if @factor.update_attributes factor_params
      redirect_to project_factors_path(@project), notice: 'Factor updated'
    else
      redirect_to project_factors_path(@project), error: 'Oops, something went wrong'
    end
  end

  def destroy
    if @factor.destroy
      redirect_to project_factors_path(@project), notice: 'Factor deleted'
    else
      redirect_to project_factors_path(@project), error: 'Oops, something went wrong'
    end
  end

  private

  def factor_params
    params.require(:factor).permit(:name, :is_negative)
  end

  def set_factor
    @factor = Factor.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end
end
