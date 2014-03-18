class IdeasController < ApplicationController
  before_action :set_idea, only: [:show, :edit, :update, :destroy]

  def new
    @idea = Idea.new
    @idea.project = Project.find(params[:project_id])
  end

  def show
  end

  def edit
  end

  def create
    @idea = Idea.new(idea_params)

    if @idea.save
      redirect_to project_idea_path(@idea.project, @idea), notice: 'Idea was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @idea.update(idea_params)
      redirect_to @idea, notice: 'Idea was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @idea.destroy
    redirect_to ideas_url
  end

  private

  def set_idea
    @idea = Idea.find(params[:id])
  end

  def idea_params
    params.require(:idea).permit(:name, :description, :project_id)
  end
end
