class ReportsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = Project.available(current_user.organisation).order(:name)
  end
end
