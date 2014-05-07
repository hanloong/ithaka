class ReportsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = Project.available(current_user.organisation).order(:name)
    @status_presenter = Ideas::StatusPresenter.new
  end
end
