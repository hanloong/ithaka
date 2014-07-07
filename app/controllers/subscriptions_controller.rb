class SubscriptionsController < ApplicationController
  before_action :set_organisation

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_organisation
    @organisation = current_user.organisation
  end

end
