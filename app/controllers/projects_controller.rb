class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.available(current_user.organisation).order(:name)
  end

  def show
    @status_presenter = Ideas::StatusPresenter.new
    if params[:search]
      @search = params[:search]
      statuses = @search[:status].map { |status| Idea.statuses[status] }
      keywords = @search[:keywords]
      @ideas = @project.ideas.where(status: statuses).where('description ILIKE ? OR name ILIKE ?', "%#{keywords}%", "%#{keywords}%")
    else
      statuses = @status_presenter.search_group.map { |status| Idea.statuses[status] }
      @ideas = @project.ideas.where(status: statuses)
      @search = { status: @status_presenter.search_group }
    end
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_url
  end

  private

  def set_project
    @project = Project.find(params[:id])
    unless @project.has_access?(current_user)
      redirect_to projects_url, alert: 'Sorry you do not have access to this project'
    end
  end

  def project_params
    params.require(:project).permit(:name, :description, :user_id, :organisation_id)
  end
end
