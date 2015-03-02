class Api::V1::IdeasController < Api::AbstractController
  before_action :set_project, only: [:index]
  before_action :set_idea, except: [:index, :new, :create]

  def index
    respond_with @project.ideas
  end

  def show
    render json: @idea
  end

  def create
    if can_create? idea_params[:project_id]
      @idea = Idea.create identified_idea_params
      show
    else
      render :json, {error: 'Sorry you do not have access to this project' }, status: :forbidden
    end
  end

  def update
  end

  def destroy
  end

  private

  def idea_params
    params.require(:idea).permit(:name, :description, :project_id)
  end

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

  def can_create?(project_id)
    Project.find(project_id).has_access?(current_user)
  end

  def identified_idea_params
    idea_params.merge({
      user_id: current_user.id,
      status: 'discussing'
    })
  end
end
