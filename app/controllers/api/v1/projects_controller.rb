class Api::V1::ProjectsController < Api::AbstractController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    respond_with @projects = Project.available(current_user.organisation).order(:name)
  end

  def show
    respond_with @project
  end

  def create
    project = Project.create identified_project_params
    respond_with project
  end

  def update
  end

  def destroy
  end

  private

  def set_project
    @project = Project.find(params[:id])
    unless @project.has_access?(current_user)
      render :json, {error: 'Sorry you do not have access to this project' }, status: :forbidden
    end
  end

  def project_params
    params.require(:project).permit(:name, :description, :allow_anonymous)
  end

  def identified_project_params
    project_params.merge({
      user_id: current_user.id,
      organisation_id: current_user.organisation_id
    })
  end
end
