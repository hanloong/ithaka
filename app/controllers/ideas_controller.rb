class IdeasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_idea, only: [:show, :edit, :update, :destroy, :unlock, :release]

  def new
    @idea = Idea.new
    @idea.project = @project
  end

  def show
    if params[:hidden]
      @comments = @idea.comments
    else
      @comments = @idea.comments.visible
    end
    @influences = @idea.influences
    @status_presenter = Ideas::StatusPresenter.new
  end

  def edit
  end

  def create
    @idea = Idea.new(idea_params.merge(status: 0))

    if @idea.save
      redirect_to project_idea_path(@idea.project, @idea),
                  notice: 'Idea was successfully created.'
    else
      flash[:error] = "Oops something went wrong"
      render action: 'new'
    end
  end

  def update
    if @idea.update(idea_params)
      redirect_to project_idea_path(@idea.project_id, @idea),
                  notice: 'Idea was successfully updated.'
    else
      flash[:error] = "Oops something went wrong"
      render action: 'edit'
    end
  end

  def destroy
    @idea.destroy
    redirect_to project_path(params[:project_id])
  end

  def unlock
    if @idea.manager?(current_user)
      @idea.unlock_votes
      redirect_to project_idea_path(@idea.project_id, @idea),
                  notice: 'All votes have been unlocked'
    else
      redirect_to project_idea_path(@idea.project_id, @idea),
                  error: 'Only owners and admins can unclock votes, sorry'
    end
  end

  def release
    if @idea.manager?(current_user)
      @idea.votes.destroy_all
      redirect_to project_idea_path(@idea.project_id, @idea),
                  notice: 'All votes have been released.'
    else
      redirect_to project_idea_path(@idea.project_id, @idea),
                  error: 'Only owners and admins can release votes, sorry'
    end
  end

  private

  def set_idea
    @idea = Idea.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
    unless @project.has_access?(current_user)
      redirect_to projects_url, error: 'Sorry you do not have access to this project'
    end
  end

  def idea_params
    params.require(:idea).permit(:name, :status, :description, :project_id, :user_id, :anonymous)
  end
end
