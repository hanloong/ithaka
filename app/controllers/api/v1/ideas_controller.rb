class Api::V1::IdeasController < Api::AbstractController
  before_action :set_project, only: [:index]
  before_action :set_idea, except: [:index]

  def index
    respond_with @project.ideas
  end

  def show
    respond_with @idea
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def set_idea
    @idea = Idea.find_by(id: params[:id])
    unless @idea.project.has_access?(current_user)
      render :json, {error: 'Sorry you do not have access to this project' }, status: :forbidden
    end
  end

  def set_project
    @project = Project.find(params[:project_id])
    unless @project.has_access?(current_user)
      render :json, {error: 'Sorry you do not have access to this project' }, status: :forbidden
    end
  end
end
