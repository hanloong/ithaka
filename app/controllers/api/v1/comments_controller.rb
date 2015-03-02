class Api::V1::CommentsController < Api::AbstractController
  before_action :set_idea, only: [:index]
  before_action :set_comment, except: [:index, :new, :create]

  def index
    respond_with @idea.comments
  end

  def show
    render json: @comment
  end

  def create
    if can_create? comment_params[:idea_id]
      @comment = Comment.create identified_comment_params
      show
    else
      render :json, {error: 'Sorry you do not have access to this idea' }, status: :forbidden
    end
  end

  def update
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :anonymous, :idea_id)
  end

  def set_idea
    @idea = Idea.find_by(id: params[:id])
    unless @idea.project.has_access?(current_user)
      render :json, {error: 'Sorry you do not have access to this project' }, status: :forbidden
    end
  end

  def set_comment
    @comment = Comment.find(params[:id])
    unless @comment.project.has_access?(current_user)
      render :json, {error: 'Sorry you do not have access to this project' }, status: :forbidden
    end
  end

  def can_create?(project_id)
    Project.find(project_id).has_access?(current_user)
  end

  def identified_comment_params
    idea_params.merge({
      user_id: current_user.id
    })
  end
end
