class IdeasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_idea, only: [:show, :edit, :update, :destroy, :unlock]
  before_action :set_project, only: [:new]

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
  end

  def edit
  end

  def create
    @idea = Idea.new(idea_params)

    if @idea.save
      redirect_to project_idea_path(@idea.project, @idea),
                  notice: 'Idea was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @idea.update(idea_params)
      redirect_to project_idea_path(@idea.project_id, @idea),
                  notice: 'Idea was successfully updated.'
    else
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
      flash[:notice] = 'All votes have been unlocked'
    else
      flash[:error] = 'Only owners and admins can unclock votes, sorry'
    end
    render 'show'
  end

  private

  def set_idea
    @idea = Idea.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def idea_params
    params.require(:idea).permit(:name, :status, :description, :project_id, :user_id)
  end
end
