class Api::V1::ProjectsController < ApiController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    render json: @projects = Project.available(current_user.organisation).order(:name)
  end

  def show
    render json: @project
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def set_project
    @project = Project.find(params[:id])
    unless @project.has_access?(current_user)
      redirect_to projects_url, alert: 'Sorry you do not have access to this project'
    end
  end

  def project_params
    params.require(:project).permit(:name, :description, :user_id, :organisation_id, :allow_anonymous)
  end
end
